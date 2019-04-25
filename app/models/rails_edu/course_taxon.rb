module RailsEdu::CourseTaxon
  extend ActiveSupport::Concern
  included do
    has_many :courses, dependent: :nullify
  end
  
end
