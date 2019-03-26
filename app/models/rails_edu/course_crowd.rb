class CourseCrowd < ApplicationRecord
  belongs_to :course
  belongs_to :crowd

  has_many :course_students

end
