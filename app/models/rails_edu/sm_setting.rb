module RailsEdu::SmSetting
  extend ActiveSupport::Concern
  
  def set_working
    self.class.transaction do
      self.update(working: true)
      SmSetting.where.not(id: self.id).update_all(working: false)
    end
  end
  
  class_methods do
    def working
      order(id: :asc).find_by(working: true)
    end
  end

end
