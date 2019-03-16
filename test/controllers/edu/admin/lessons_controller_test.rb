require 'test_helper'

class Edu::Admin::LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edu_admin_lesson = create edu_admin_lessons
  end

  test 'index ok' do
    get admin_lessons_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_lesson_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Lesson.count') do
      post admin_lessons_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to edu_admin_lesson_url(Lesson.last)
  end

  test 'show ok' do
    get admin_lesson_url(@edu_admin_lesson)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_lesson_url(@edu_admin_lesson)
    assert_response :success
  end

  test 'update ok' do
    patch admin_lesson_url(@edu_admin_lesson), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to edu_admin_lesson_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Lesson.count', -1) do
      delete admin_lesson_url(@edu_admin_lesson)
    end

    assert_redirected_to admin_lessons_url
  end
end
