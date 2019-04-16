class CourseCrowd < ApplicationRecord
  include RailsBookingPlan

  belongs_to :course
  belongs_to :crowd
  belongs_to :teacher, optional: true

  has_many :course_plans, dependent: :destroy
  has_many :course_students

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

  def sync
    r = self.next_occurrences.flatten
    r = r.map { |i| i[:occurrences] }.flatten
    r.each do |i|
      cp = self.course_plans.find_or_initialize_by(booking_on: i[:date], time_item_id: i[:id])
      cp.room_id  = i.fetch(:room, {}).fetch('id')
      cp.save
    end
  end


end
