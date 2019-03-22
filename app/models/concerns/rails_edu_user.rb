module RailsEduUser
  extend ActiveSupport::Concern
  included do
    has_many :course_students, dependent: :destroy
    has_many :courses, through: :course_students
    has_many :exams, dependent: :destroy
  end


end
