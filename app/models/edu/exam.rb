module Edu
  class Exam < ApplicationRecord
    include Notice::Ext::Notifiable if defined? RailsNotice
    include Model::Exam
  end
end
