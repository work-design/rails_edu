class LessonStudent < ApplicationRecord
  belongs_to :lesson
  belongs_to :course
  belongs_to :student, polymorphic: true
  belongs_to :course_student, ->(o){ where(student_type: o.student_type, student_id: o.student_id) }, foreign_key: :course_id, primary_key: :course_id

end
