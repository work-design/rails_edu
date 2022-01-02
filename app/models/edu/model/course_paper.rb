module Edu
  module Model::CoursePaper
    extend ActiveSupport::Concern

    included do
      belongs_to :course, optional: true
      has_many :exams, dependent: :nullify
      has_one_attached :document
    end

  end
end
