json.course @course_plan.course, :id, :title
json.course_students @course_students, partial: 'course_student', as: :course_student
if @course_plan.lesson_id
  json.lesson @course_plan.lesson, :id, :title
end
