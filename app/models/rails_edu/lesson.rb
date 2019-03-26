class Lesson < ApplicationRecord
  belongs_to :course
  has_many :lesson_students
  has_many :students, through: :lesson_students, source_type: 'Profile'

  has_many_attached :videos
  has_many_attached :documents

end
