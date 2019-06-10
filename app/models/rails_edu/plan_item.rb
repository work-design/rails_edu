module RailsEdu::PlanItem
  extend ActiveSupport::Concern
  included do
    belongs_to :course, optional: true
    belongs_to :lesson, optional: true
    belongs_to :teacher, optional: true
    belongs_to :room, optional: true

    has_many :lesson_students, dependent: :nullify
  end
  
  
  def students
    lesson_students.pluck(:student_type, :student_id).map { |i| i.join('_') }
  end
  
end
