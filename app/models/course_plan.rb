class CoursePlan < ApplicationRecord
  include RailsBooking::Booked
  include RailsEdu::CoursePlan
end unless defined? CoursePlan
