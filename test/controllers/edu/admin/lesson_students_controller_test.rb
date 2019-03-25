require 'test_helper'

class Edu::Admin::LessonStudentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edu_admin_lesson_student = create edu_admin_lesson_students
  end

  test 'index ok' do
    get admin_lesson_students_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_lesson_student_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('LessonStudent.count') do
      post admin_lesson_students_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to edu_admin_lesson_student_url(LessonStudent.last)
  end

  test 'show ok' do
    get admin_lesson_student_url(@edu_admin_lesson_student)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_lesson_student_url(@edu_admin_lesson_student)
    assert_response :success
  end

  test 'update ok' do
    patch admin_lesson_student_url(@edu_admin_lesson_student), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to edu_admin_lesson_student_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('LessonStudent.count', -1) do
      delete admin_lesson_student_url(@edu_admin_lesson_student)
    end

    assert_redirected_to admin_lesson_students_url
  end
end
