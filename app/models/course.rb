class Course < ApplicationRecord
  include RailsEdu::Course
  include RailsBooking::Plan
  include RailsBooking::PlanItemize
end unless defined? Course
