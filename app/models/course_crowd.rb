class CourseCrowd < ApplicationRecord
  include RailsBooking::Plan
  include RailsEdu::CourseCrowd
end unless defined? CourseCrowd
