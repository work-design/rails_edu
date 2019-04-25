module RailsEdu::CoursePaper::ExamPaper
  extend ActiveSupport::Concern
  included do
    after_initialize if: :new_record? do
      self.title ||= "Exam_#{self.course&.title}"
    end
  end
  
end
