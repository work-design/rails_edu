class Course < ApplicationRecord
  belongs_to :course_taxon, optional: true
  belongs_to :author, class_name: 'Teacher', optional: true

  has_many :lessons

  has_many :course_crowds
  has_many :crowds, through: :course_crowds
  has_many :course_students, dependent: :destroy
  has_many :students, through: :course_students

  has_many :course_grants, dependent: :destroy
  has_many :course_papers, dependent: :destroy
  has_many :exam_papers, dependent: :destroy
  has_many :survey_papers, dependent: :destroy
  has_many :exams, dependent: :destroy

  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      CourseStudentMailer.assign(self.id).deliver_later
      job = CourseStudentMailer.remind(self.id).deliver_later(wait_until: self.course.next_start_at - 1.day)
      self.update(job_id: job.job_id)
    end
  end

  def timestamp
    self.course_students.order(created_at: :desc).first&.created_at.to_i
  end

end
