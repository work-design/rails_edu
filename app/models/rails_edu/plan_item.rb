module RailsEdu::PlanItem
  extend ActiveSupport::Concern
  
  included do
    belongs_to :teacher, class_name: 'Member', optional: true
    belongs_to :room, optional: true
    belongs_to :course, optional: true
    belongs_to :crowd, optional: true
    
    belongs_to :lesson, optional: true
  end
  
  
  def students
    plan_attenders.where(attended: true).pluck(:attender_type, :attender_id).map { |i| i.join('_') }
  end
  
end
