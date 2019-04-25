class Student < ApplicationRecord
  include RailsEdu::Student
end unless defined? Student
