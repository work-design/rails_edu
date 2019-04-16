class CoursePlan < ApplicationRecord
  include RailsTimeBooked

  attribute :booking_on, :date
  attribute :time_bookings_count, :integer, default: 0

  belongs_to :course
  belongs_to :lesson, optional: true


end
