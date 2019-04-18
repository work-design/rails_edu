class LessonStudent < ApplicationRecord
  belongs_to :lesson
  belongs_to :course
  belongs_to :student, polymorphic: true
  belongs_to :course_student


  has_one :card_log, ->(o){ where(card_id: o.student.card_id) }, as: :source


  before_validation :sync_course_student
  after_commit :sync_card_log

  def sync_course_student
    self.course_id = course_student.course_id
    self.student_type = course_student.student_type
    self.student_id = course_student.student_id
  end

  def sync_card_log
    
  end

end
