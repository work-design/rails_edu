class CoursePlan < ApplicationRecord
  include RailsBookingBooked

  attribute :booking_on, :date
  attribute :time_bookings_count, :integer, default: 0

  belongs_to :course
  belongs_to :time_item
  belongs_to :lesson, optional: true

  validates :booking_on, presence: true


end
