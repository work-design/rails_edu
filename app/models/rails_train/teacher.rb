class Teacher < ApplicationRecord
  belongs_to :user, optional: true

  def allow_ids
    self.id
  end
end
