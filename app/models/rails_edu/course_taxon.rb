class CourseTaxon < ApplicationRecord
  has_many :courses, dependent: :nullify

end
