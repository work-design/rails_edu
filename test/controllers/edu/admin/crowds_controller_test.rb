require 'test_helper'

class Edu::Admin::CrowdsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @edu_admin_crowd = create edu_admin_crowds
  end

  test 'index ok' do
    get admin_crowds_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_crowd_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Crowd.count') do
      post admin_crowds_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to edu_admin_crowd_url(Crowd.last)
  end

  test 'show ok' do
    get admin_crowd_url(@edu_admin_crowd)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_crowd_url(@edu_admin_crowd)
    assert_response :success
  end

  test 'update ok' do
    patch admin_crowd_url(@edu_admin_crowd), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to edu_admin_crowd_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Crowd.count', -1) do
      delete admin_crowd_url(@edu_admin_crowd)
    end

    assert_redirected_to admin_crowds_url
  end
end
