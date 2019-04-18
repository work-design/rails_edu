json.lesson @lesson, :id, :title
json.course @lesson.course, :id, :title
json.course_students @course_students, partial: 'course_student', as: :course_student
