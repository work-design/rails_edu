module RailsEdu::CourseCrowd
  extend ActiveSupport::Concern

  included do
    attribute :present_number, :integer
    attribute :limit_number, :integer
  
    belongs_to :course
    belongs_to :crowd
    belongs_to :teacher, optional: true
    belongs_to :room, optional: true
    
    has_many :crowd_students, foreign_key: :crowd_id, primary_key: :crowd_id
    has_many :course_plans, dependent: :destroy
    has_many :course_students
    has_many :lessons, foreign_key: :course_id, primary_key: :course_id
  
    after_create_commit :sync_to_course_students
    after_destroy_commit :destroy_from_course_students
    after_update_commit :sync_to_course_plans
  
    delegate :title, to: :course
  end
  
  def sync_to_course_students
    self.crowd.students.each do |i|
      cs = i.course_students.build(student_id: i.id, course_id: self.course_id)
      cs.save
    end
  end

  def sync_to_course_plans
    if saved_change_to_teacher_id?
      self.course_plans.where(teacher_id: nil).update_all(teacher_id: self.teacher_id)
    end
    if saved_change_to_room_id?
      self.course_plans.where(room_id: nil).update_all(room_id: self.room_id)
    end
  end

  def destroy_from_course_students
    self.crowd.students.each do |i|
      cs = i.course_students.find_by(student_id: i.id)
      cs&.destroy
    end
  end

  def sync(start:, finish:)
    removes, adds = self.xx.diff_changes self.next_days(start: start, finish: finish)
    
    removes.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        self.course_plans.where(booking_on: date, time_item_id: time_item_id).delete_all
      end
    end

    adds.each do |date, time_item_ids|
      Array(time_item_ids).each do |time_item_id|
        cp = self.course_plans.find_or_initialize_by(booking_on: date, time_item_id: time_item_id)
        cp.save
      end
    end
  end

  def xx
    self.course_plans.order(booking_on: :asc).group_by(&->(i){i.booking_on.to_s}).transform_values! do |v|
      v.map(&:time_item_id)
    end
  end

end
