class OfflineCourse < Course
  include RailsEdu::Course::OfflineCourse
end unless defined? OfflineCourse
