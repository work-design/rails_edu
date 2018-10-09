class LessonGrant < ApplicationRecord
  belongs_to :lesson
  belongs_to :department
  belongs_to :band, optional: true

end
