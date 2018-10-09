class SurveyPaper < LessonPaper
  TEMP = {
    'OfflineLesson' => '151607259',
    'OnlineLesson' => '151606841',
    'ShareLesson' => '151607332'
  }

  after_initialize if: :new_record? do
    self.title ||= "Survey_#{self.lesson&.title}"
  end

  def add
    template_id = TEMP[self.lesson.type]
    r = SurveyMonkey.create_survey(self.title, from_survey_id: template_id)
    self.link = r['summary_url']
    self.entity_id = r['id']
    self.save
  end

end
