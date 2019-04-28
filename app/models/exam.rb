class Exam < ApplicationRecord
  include RailsNotice::Notifiable
  include RailsEdu::Exam
end unless defined? Exam
