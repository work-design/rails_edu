module RailsEduUser
  extend ActiveSupport::Concern
  included do
    has_many :course_members, dependent: :destroy
    has_many :courses, through: :course_members
    has_many :exams, dependent: :destroy
  end


end
