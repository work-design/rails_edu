class CourseCrowd < ApplicationRecord
  include RailsBooking::Plan
  include RailsBooking::PlanItemize
  include RailsEdu::CourseCrowd
end unless defined? CourseCrowd
