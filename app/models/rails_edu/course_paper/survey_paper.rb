module RailsEdu::CoursePaper::SurveyPaper
  TEMP = {
    'OfflineCourse' => '151607259',
    'OnlineCourse' => '151606841',
    'ShareCourse' => '151607332'
  }.freeze
  extend ActiveSupport::Concern
  included do
    after_initialize if: :new_record? do
      self.title ||= "Survey_#{self.course&.title}"
    end
  end

  def add
    template_id = TEMP[self.course.type]
    r = SurveyMonkey.create_survey(self.title, from_survey_id: template_id)
    self.link = r['summary_url']
    self.entity_id = r['id']
    self.save
  end

end
