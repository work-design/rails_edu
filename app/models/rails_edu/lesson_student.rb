class LessonStudent < ApplicationRecord

  attribute :attended, :boolean, default: true

  belongs_to :course
  belongs_to :student, polymorphic: true
  belongs_to :course_student
  belongs_to :course_crowd
  belongs_to :course_plan
  belongs_to :lesson, optional: true
  has_many :card_logs, ->(o){ where(card_id: o.student.card_id) }, as: :source

  before_validation :sync_course_student
  after_create_commit :sync_card_log
  after_destroy_commit :sync_revert_card_log

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

end
