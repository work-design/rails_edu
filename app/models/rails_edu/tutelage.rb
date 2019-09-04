module RailsEdu::Tutelage
  extend ActiveSupport::Concern
  
  included do
    has_many :crowd_students
    has_many :crowds, through: :crowd_students
  end

  def join_crowd(crowd_id)
    cs = self.crowd_students.build
    cs.student = pupil
    cs.crowd_id = crowd_id
    cs.save
  end

end
