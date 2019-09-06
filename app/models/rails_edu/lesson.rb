module RailsEdu::Lesson
  extend ActiveSupport::Concern
  included do
    belongs_to :course
    belongs_to :author, class_name: 'Member', optional: true
    has_many :lesson_students
    has_many :students, through: :lesson_students, source_type: 'Profile'
  
    has_many_attached :videos
    has_many_attached :documents
  end
  
  
  def video_urls
    videos.map(&:service_url)
  end
  
  def document_urls
    documents.map(&:service_url)
  end
  
end
