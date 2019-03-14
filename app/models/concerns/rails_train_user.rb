module RailsEduUser
  extend ActiveSupport::Concern
  included do
    has_many :lesson_members, dependent: :destroy
    has_many :lessons, through: :lesson_members
    has_many :exams, dependent: :destroy
  end


end
