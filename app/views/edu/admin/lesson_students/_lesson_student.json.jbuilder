json.extract! lesson_student,
              :id,
              :attended,
              :course_student_id,
              :created_at
json.student lesson_student.student,
             :id,
             :real_name,
             :nick_name,
             :age,
             :birthday
