module RailsEdu::Exam
  extend ActiveSupport::Concern
  include StateMachine

  included do
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

  def sync_answer
    self.sync_answer_detail
    self.sync_answer_result
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
