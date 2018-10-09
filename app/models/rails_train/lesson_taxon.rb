class LessonTaxon < ApplicationRecord
  has_many :lessons, dependent: :nullify

end
