module RailsEdu::Teacher
  extend ActiveSupport::Concern
  included do
    has_many :course_plans
  
    has_many :review_exams, class_name: 'Exam', foreign_key: :reviewer_id, inverse_of: 'reviewer'
  end


end
