class CourseCrowd < ApplicationRecord
  belongs_to :course
  belongs_to :crowd
  belongs_to :teacher

  has_many :course_students

  after_create_commit :sync_to_course_students
  after_destroy_commit :destroy_from_course_students

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

end
