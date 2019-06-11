json.course @course_crowd.course, :id, :title
json.course_students @course_students, partial: 'course_student', as: :course_student
if @plan_item&.lesson
  json.lesson @plan_item.lesson, :id, :title
end
