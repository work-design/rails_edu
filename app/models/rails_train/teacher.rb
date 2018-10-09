class Teacher < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :member, optional: true

  before_save :sync_user_id, if: -> { member_id_changed? }

  def sync_user_id
    self.user_id = self.member&.user&.id
  end

  def allow_ids
    self.id
  end
end
