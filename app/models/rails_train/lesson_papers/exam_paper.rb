class ExamPaper < LessonPaper

  after_initialize if: :new_record? do
    self.title ||= "Exam_#{self.lesson&.title}"
  end

end
