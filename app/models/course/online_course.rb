class OnlineCourse < Course
  include RailsEdu::Course::OnlineCourse
end unless defined? OnlineCourse
