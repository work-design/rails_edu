json.extract! course_student,
              :id,
              :state,
              :created_at
json.student course_student.student,
             :id,
             :real_name,
             :nick_name,
             :age
json.attended @course_plan.student_ids.include?(course_student.student_id)
