require 'test_helper'

class Edu::Admin::CoursePlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edu_admin_course_plan = create edu_admin_course_plans
  end

  test 'index ok' do
    get admin_course_plans_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_course_plan_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('CoursePlan.count') do
      post admin_course_plans_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to edu_admin_course_plan_url(CoursePlan.last)
  end

  test 'show ok' do
    get admin_course_plan_url(@edu_admin_course_plan)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_course_plan_url(@edu_admin_course_plan)
    assert_response :success
  end

  test 'update ok' do
    patch admin_course_plan_url(@edu_admin_course_plan), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to edu_admin_course_plan_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('CoursePlan.count', -1) do
      delete admin_course_plan_url(@edu_admin_course_plan)
    end

    assert_redirected_to admin_course_plans_url
  end
end
