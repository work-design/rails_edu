class CrowdStudent < ApplicationRecord
  belongs_to :crowd
  belongs_to :student, class_name: ->(o){ o.crowd.type }

end
