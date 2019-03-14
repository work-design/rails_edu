class SmSetting < ApplicationRecord

  def set_working
    self.class.transaction do
      self.update(working: true)
      SmSetting.where.not(id: self.id).update_all(working: false)
    end
  end

  def self.working
    order(id: :asc).find_by(working: true)
  end

end
