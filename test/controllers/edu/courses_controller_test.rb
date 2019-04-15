require 'test_helper'

class Edu::CoursesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edu_course = create edu_courses
  end

  test 'index ok' do
    get edu_courses_url
    assert_response :success
  end

  test 'new ok' do
    get new_edu_course_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Course.count') do
      post edu_courses_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to edu_course_url(Course.last)
  end

  test 'show ok' do
    get edu_course_url(@edu_course)
    assert_response :success
  end

  test 'edit ok' do
    get edit_edu_course_url(@edu_course)
    assert_response :success
  end

  test 'update ok' do
    patch edu_course_url(@edu_course), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to edu_course_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Course.count', -1) do
      delete edu_course_url(@edu_course)
    end

    assert_redirected_to edu_courses_url
  end
end
