module RailsEdu::CrowdStudent
  extend ActiveSupport::Concern
  included do
    belongs_to :crowd, counter_cache: true
    belongs_to :student, polymorphic: true
    belongs_to :tutelage, optional: true
  
    after_destroy_commit :quit_course
  end
  
  def quit_course
  
  end

end
