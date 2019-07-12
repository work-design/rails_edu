module RailsEdu::User
  extend ActiveSupport::Concern
  
  included do
    has_many :proteges, through: :profiles
    has_many :maintains, through: :proteges, source: :maintains
  end
  
end
