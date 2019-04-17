class Exam < ApplicationRecord
  include RailsNoticeNotifiable
  include StateMachine
  belongs_to :course_paper, optional: true
  belongs_to :course, optional: true
  belongs_to :member
  belongs_to :reviewer, class_name: 'Member', inverse_of: 'review_exams', counter_cache: 'review_exams_count', optional: true
  has_one :course_student, ->(o){ where(member_id: o.member_id) }, primary_key: 'course_id', foreign_key: 'course_id'
  serialize :answer_detail, Hash

  enum state: {
    init: 'init',
    finished: 'finished',
    evaluated: 'evaluated'
  }
  scope :processing, -> { default_where(state: 'evaluated', 'answer_mark-gte': 60).or(Exam.where(state: ['init', 'finished'])) }

  after_initialize if: :new_record? do
    self.state ||= 'init'
    self.course_id = self.course_paper&.course_id
  end

  def set_finish
    return if self.finished?
    self.set_reviewer
    self.trigger_to! state: 'finished'
    if self.course_paper.is_a?(ExamPaper)
      ExamMailer.review(self.id).deliver_later
      ExamJob.perform_later(self.id)
    end
  end

  def custom_link
    if course_paper.link.present?
      to_survey_monkey
    else
      to_one_drive
    end
  end

  def update_score(params)
    self.answer_mark = params[:answer_mark]
    self.comment = params[:comment]
    self.state = 'evaluated'
    course_student&.score = self.answer_mark

    if Integer(answer_mark) >= 60
      course_student&.state = 'passed'
    else
      course_student&.state = 'failed'
    end

    self.class.transaction do
      self.save!
      course_student&.save!
    end
    ExamMailer.result(self.id).deliver_later
  end

  def set_reviewer
    if self.course_paper.is_a?(CertifiablePaper)
      self.reviewer_id = self.member.exam_reviewers.order(review_exams_count: :asc).first.id
    end
  end

  def reviewer
    if super
      super
    elsif self.member.tutor
      self.member.tutor
    else
      self.member.parent || Member.find_by(email: 'mingyuan.qin@mdpi.com')
    end
  end

  def close_date
    if course_paper.is_a?(CertifiablePaper)
      Time.now.change(hour: 18, min: 15)
    end
    #(Time.now + 10.minutes).to_s(:iso8601)
  end

  def enabled?
    (Time.now > Time.now.change(hour: 16, min: 59)) && self.link
  end

  def to_survey_monkey
    path = "surveys/#{course_paper.entity_id}/collectors"
    body = {
      type: 'weblink',
      name: member.name,
      redirect_type: 'url',
      redirect_url: url_helpers.finish_my_exam_url(self.id)
    }
    if close_date
      body.merge! close_date: close_date.to_s(:iso8601)
    end

    r = SurveyMonkey.post path, body: body

    self.link = r['url']
    self.entity_id = r['id']
    self.save
  end

  def to_one_drive
    ms_user = self.member.user.oauth_users.find_by(type: 'MsUser')
    if ms_user
      response = ms_user.one_drive.put CGI.escape("/me/drive/root:/FolderA/#{course_paper.document.filename.to_s}:/content"), body: course_paper.document.download
      if response.status.to_s.start_with? '2'
        self.link = response.parsed['webUrl']
        self.entity_id = response.parsed['id']
        self.start_at = response.parsed['lastModifiedDateTime']
        self.save
      else
        msg = response.error.code['message']
        self.errors.add :onedrive_item, msg
      end
    end
  end

  def sync_answer
    self.sync_answer_detail
    self.sync_answer_result
  end

  def sync_answer_detail
    ans = SurveyMonkey.get "collectors/#{self.entity_id}/responses"

    if ans.fetch('data', {}).size >= 1
      detail_id = ans['data'].first['id']
      details = SurveyMonkey.get "collectors/#{self.entity_id}/responses/#{detail_id}/details"
      details['pages']
    else
      logger.debug 'answers not exists!'
      return self.update(state: 'init')
    end

    pages = details['pages']
    _details = {}
    pages.each do |page|
      ques = SurveyMonkey.get "surveys/#{course_paper.entity_id}/pages/#{page['id']}/questions"
      headings = ques['data'].map { |que| { que['id'] => que['heading'] } }
      answers = page['questions'].map { |que| { que['id'] => que['answers'].map(&:values).join(', ') } }
      _results = (headings + answers).to_combine_h
      _results.transform_keys! { |key| [page['id'], key].join('/') }
      _details.merge! _results
    end

    self.answer_detail = _details
    self.spent_minutes = (details['total_time'].to_i / 60.0).ceil
    self.finish_at = details['date_modified']
    self.save
    self.answer_detail
  end

  def sync_answer_result
    answer_detail.each do |key, value|
      next unless (value.is_a?(Array) && value.size > 1)

      page_id, que_id = key.split('/')
      que_detail = SurveyMonkey.get "surveys/#{course_paper.entity_id}/pages/#{page_id}/questions/#{que_id}"

      choices = que_detail.dig('answers', 'choices')
      if choices.present?
        ans = value[1].split(', ')
        r = choices.select { |i| ans.include?(i['id']) }.map { |i| i['position'] }
        value[1] = r

        value[2] = choices.map { |i| [i['position'], i['text']].join('. ') if i['visible'] }
        next
      end

      rows = que_detail.dig('answers', 'rows')
      if rows.present?
        _ans = value[1].split(', ')
        _row, ans = _ans.partition.with_index { |_, i| i.odd? }
        r = rows.select { |i| _row.include?(i['id']) }.map { |i| i['text'] }
        value[1] = r.zip ans
      end
    end
    self.save
  end

  def referred_answer_detail
    answer_detail.map do |qid, value|
      if referenced_exam
        _r_value = referenced_exam.answer_detail[qid]
        r_value = Array(_r_value)[1]
      else
        r_value = nil
      end

      r = (r_value == value[1])
      [value[0], r_value, value[1], r, Array(value[2])]
    end
  end

  def set_referenced
    self.class.transaction do
      self.update(referenced: true)
      Exam.where.not(id: self.id).where(course_paper_id: self.course_paper_id).update_all(referenced: false)
    end
  end

  def referenced_exam
    @referenced_exam ||= Exam.find_by(course_paper_id: self.course_paper_id, referenced: true)
  end

end
