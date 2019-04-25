module RailsEdu::CourseGrant
  extend ActiveSupport::Concern
  included do
    belongs_to :course
  end
  
end
