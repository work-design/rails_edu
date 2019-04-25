module RailsEdu::CoursePlan
  extend ActiveSupport::Concern
  included do
    include RailsBookingBooked
  
    attribute :booking_on, :date
    attribute :time_bookings_count, :integer, default: 0
  
    belongs_to :course
    belongs_to :time_item
    belongs_to :course_crowd
    belongs_to :lesson, optional: true
    belongs_to :teacher, optional: true
    belongs_to :room, optional: true
  
    has_many :lesson_students, dependent: :nullify
    has_many :students, through: :lesson_students, source_type: 'Profile'
  
    validates :booking_on, presence: true
  
    scope :valid, -> { default_where('booking_on-gte': Date.today) }
  
    after_initialize if: :new_record? do
      if course_crowd
        self.course_id = course_crowd.course_id
        self.teacher_id ||= course_crowd.teacher_id
      end
    end
  end
  
  def to_event
    {
      id: id,
      start: time_item.start_at.change(booking_on.parts).strftime('%FT%T'),
      end: time_item.finish_at.change(booking_on.parts).strftime('%FT%T'),
      title: "#{room.name} #{course.title}",
      extendedProps: {
        title: course.title,
        time_item_id: time_item_id,
        booking_on: booking_on,
        course_crowd_id: course_crowd_id,
        room: room.as_json(only: [:id], methods: [:name]),
        crowd: course_crowd.crowd.as_json(only: [:id, :name])
      }
    }
  end

end
