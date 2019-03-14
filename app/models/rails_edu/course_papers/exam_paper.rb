class ExamPaper < CoursePaper

  after_initialize if: :new_record? do
    self.title ||= "Exam_#{self.course&.title}"
  end

end
