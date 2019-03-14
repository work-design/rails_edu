class CoursePaper < ApplicationRecord
  belongs_to :course, optional: true
  has_many :exams, dependent: :nullify
  has_one_attached :document

  def add
    r = SurveyMonkey.create_survey(self.title)
    self.link = r['summary_url']
    self.entity_id = r['id']
    self.save
  end

end
