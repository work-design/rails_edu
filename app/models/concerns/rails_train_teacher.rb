module RailsTrainTeacher
  extend ActiveSupport::Concern
  included do
    has_many :review_exams, class_name: 'Exam', foreign_key: :reviewer_id, inverse_of: 'reviewer'

  end


end
