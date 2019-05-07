module RailsEdu::CrowdStudent
  extend ActiveSupport::Concern
  included do
    belongs_to :crowd, counter_cache: true
    belongs_to :student, polymorphic: true
  
    after_initialize if: :new_record? do
      self.student_type = self.crowd.student_type if crowd
    end
    after_destroy_commit :quit_course
  end
  
  def quit_course
  
  end

end
