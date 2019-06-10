module RailsEdu::PlanItem
  extend ActiveSupport::Concern
  included do
    belongs_to :course, optional: true
    belongs_to :lesson, optional: true
    belongs_to :teacher, optional: true
    belongs_to :room, optional: true

    has_many :lesson_students, dependent: :nullify
    has_many :students, through: :lesson_students, source_type: 'Profile'
  end
  
end
