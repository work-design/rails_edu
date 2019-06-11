json.extract! course_student,
              :id,
              :state,
              :created_at
json.student course_student.student,
             :id,
             :real_name,
             :nick_name,
             :age,
             :birthday
json.attended @plan_item.students.include?("#{course_student.student_type}_#{course_student.student_id}")
