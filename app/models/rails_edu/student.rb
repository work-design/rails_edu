module RailsEdu::Student
  extend ActiveSupport::Concern
  included do
    has_many :course_students, as: :student, dependent: :destroy
    has_many :courses, through: :course_students
    #has_many :exams, dependent: :destroy

    has_many :crowd_students, as: :student, dependent: :destroy
    has_many :crowds, through: :crowd_students
  end


  def join_crowd(crowd_id)
    cs = self.crowd_students.build
    cs.crowd_id = crowd_id
    cs.save
  end

end
