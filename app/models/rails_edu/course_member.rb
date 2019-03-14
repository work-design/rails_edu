class CourseMember < ApplicationRecord
  include StateMachine
  attribute :state, :string, default: 'in_studying'
  belongs_to :course, counter_cache: true
  belongs_to :student, polymorphic: true

  validates :member_id, uniqueness: { scope: :course_id }

  enum state: {
    in_studying: 'in_studying',
    request_quit: 'request_quit',
    quitted: 'quitted',
    in_evaluating: 'in_evaluating',
    passed: 'passed',
    failed: 'failed'
  }

  after_destroy :delete_reminder_job

  def save_with_remind
    self.class.transaction do
      self.save!
    end

    return unless self.persisted?

    self.class.transaction do
      CourseMemberMailer.assign(self.id).deliver_later
      if self.course.next_start_time
        job = CourseMemberMailer.remind(self.id).deliver_later(wait_until: self.course.next_start_time - 1.day)
        self.update(job_id: job.job_id)
      end
    end
  end

  def delete_reminder_job
    ActionMailer::DeliveryJob.cancel(self.job_id)
  end

end
