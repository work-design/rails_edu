module RailsEdu::CourseStudent
  extend ActiveSupport::Concern
  include StateMachine

  included do
    attribute :state, :string, default: 'in_studying'
    attribute :crowd_student_id, :integer
    
    belongs_to :course_crowd, optional: true
    belongs_to :course, counter_cache: true
    belongs_to :crowd_student
    belongs_to :student, polymorphic: true
    has_many :lesson_students
  
    validates :student_id, uniqueness: { scope: [:student_type, :course_id] }
  
    enum state: {
      in_studying: 'in_studying',
      request_quit: 'request_quit',
      quit: 'quit',
      in_evaluating: 'in_evaluating',
      passed: 'passed',
      failed: 'failed'
    }
    
    before_validation :sync_from_crowd_student
    after_destroy :delete_reminder_job
  end
  
  def sync_from_crowd_student
    if self.crowd_student
      self.student_type = crowd_student.student_type
      self.student_id = crowd_student.student_id
    end
  end
  
  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      CourseStudentMailer.assign(self.id).deliver_later
      if self.course.next_start_time
        job = CourseStudentMailer.remind(self.id).deliver_later(wait_until: self.course.next_start_time - 1.day)
        self.update(job_id: job.job_id)
      end
    end
  end

  def delete_reminder_job
    ActionMailer::DeliveryJob.cancel(self.job_id) if ActionMailer::DeliveryJob.respond_to?(:cancel)
  end

end
