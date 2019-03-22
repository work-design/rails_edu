class CrowdStudent < ApplicationRecord
  belongs_to :crowd, counter_cache: true
  belongs_to :student, polymorphic: true

  after_initialize if: :new_record? do
    self.student_type = self.crowd.student_type if crowd
  end

end
