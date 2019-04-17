class CourseCrowd < ApplicationRecord
  include RailsBookingPlan

  attribute :present_number, :integer
  attribute :limit_number, :integer

  belongs_to :course
  belongs_to :crowd
  belongs_to :teacher, optional: true

  has_many :course_plans, dependent: :destroy
  has_many :course_students
  has_many :lessons, foreign_key: :course_id, primary_key: :course_id

  after_create_commit :sync_to_course_students
  after_destroy_commit :destroy_from_course_students

  delegate :title, to: :course

  def sync_to_course_students
    self.crowd.students.each do |i|
      cs = i.course_students.build(student_id: i.id, course_id: self.course_id)
      cs.save
    end
  end

  def destroy_from_course_students
    self.crowd.students.each do |i|
      cs = i.course_students.find_by(student_id: i.id)
      cs&.destroy
    end
  end

  def sync_all
    removes = self.xx.simple_diff self.next_days
    adds = self.next_days.simple_diff self.xx

    adds.each do |date, time_item_id|
      cp = self.course_plans.find_or_initialize_by(booking_on: date, time_item_id: time_item_id)
      cp.room_id = i.fetch(:room, {}).fetch('id')
      cp.save
    end
  end

  def sync
    cp = self.course_plans.find_or_initialize_by(booking_on: date, time_item_id: time_item_id)
    cp.room_id = i.fetch(:room, {}).fetch('id')
  end

  def xx
    self.course_plans.order(booking_on: :asc).group_by(&->(i){i.booking_on.to_s}).transform_values! do |v|
      v.map(&:time_item_id)
    end
  end

end
