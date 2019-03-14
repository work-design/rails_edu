class CourseGrant < ApplicationRecord
  belongs_to :course
  belongs_to :department
  belongs_to :band, optional: true

end
