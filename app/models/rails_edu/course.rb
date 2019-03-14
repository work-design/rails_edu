class Course < ApplicationRecord
  include RailsBookingTime
  belongs_to :course_taxon, optional: true # todo remove
  belongs_to :author, class_name: 'Teacher', optional: true
  belongs_to :lecturer, class_name: 'Teacher', optional: true
  has_many :course_members, dependent: :destroy
  has_many :members, through: :course_member
  has_many :course_grants, dependent: :destroy
  has_many :departments, through: :course_grants
  has_many :bands, through: :course_grants
  has_many :course_papers, dependent: :destroy
  has_many :exam_papers, dependent: :destroy
  has_many :survey_papers, dependent: :destroy
  has_many :exams, dependent: :destroy

  has_many_attached :document
  has_many_attached :video
  has_many_attached :en_video

  scope :outward, -> { all }

  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      CourseMemberMailer.assign(self.id).deliver_later
      job = CourseMemberMailer.remind(self.id).deliver_later(wait_until: self.course.next_start_at - 1.day)
      self.update(job_id: job.job_id)
    end
  end

  def timestamp
    self.course_members.order(created_at: :desc).first&.created_at.to_i
  end

end
