module RailsEdu::LessonStudent
  extend ActiveSupport::Concern
  included do
    attribute :attended, :boolean, default: true
  
    belongs_to :course
    belongs_to :student, polymorphic: true
    belongs_to :course_student
    belongs_to :course_crowd, optional: true
    belongs_to :course_plan
    belongs_to :lesson, optional: true
    has_one :card_log, ->{ default_where('amount-gt': 0) }, as: :source
    has_many :card_logs, ->(o){ where(card_id: o.student.card_id) }, as: :source
  
    before_validation :sync_course_student
    after_create_commit :sync_card_log
    after_destroy_commit :sync_revert_card_log
  end
  
  def sync_course_student
    self.course_id = course_student.course_id
    self.student_type = course_student.student_type
    self.student_id = course_student.student_id
    self.course_crowd_id = course_plan.course_crowd_id
  end

  def sync_card_log
    return unless self.student.card

    log = self.card_logs.build
    log.title = '签到-核销'
    log.tag_str = '签到'
    log.save
  end

  def sync_revert_card_log
    return unless self.student.card

    log = self.card_logs.build
    log.title = '取消签到'
    log.tag_str = '签到'
    log.amount = -1
    log.save
  end
  
  def to_notification
    str = ''
    if card_log
      str << "本次消耗次数：#{card_log.amount}\n"
      str << "剩余次数：#{card_log.card.amount}\n"
    end
    str << "老师：#{lesson.teacher.name}\n" if course_plan.teacher
    str << "教室：#{lesson.room.name}\n" if course_plan.room
    str << "上课时间：#{course_plan.start_at.strftime('%F %R')}\n"
    str << "结束时间：#{course_plan.finish_at.strftime('%F %R')}\n"
  end

end
