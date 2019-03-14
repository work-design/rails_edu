class ExamReviewer < ApplicationRecord
  belongs_to :exam
  belongs_to :member
  belongs_to :reviewer, class_name: 'Member'

end
