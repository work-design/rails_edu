class Lesson < ApplicationRecord
  belongs_to :course

  has_many_attached :videos
  has_many_attached :documents

end
