require 'test_helper'

class Train::ExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @train_exam = train_exams(:one)
  end

  test "should get index" do
    get train_exams_url
    assert_response :success
  end

  test "should get new" do
    get new_train_exam_url
    assert_response :success
  end

  test "should create train_exam" do
    assert_difference('Exam.count') do
      post train_exams_url, params: { train_exam: {  } }
    end

    assert_redirected_to train_exam_url(Exam.last)
  end

  test "should show train_exam" do
    get train_exam_url(@train_exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_train_exam_url(@train_exam)
    assert_response :success
  end

  test "should update train_exam" do
    patch train_exam_url(@train_exam), params: { train_exam: {  } }
    assert_redirected_to train_exam_url(@train_exam)
  end

  test "should destroy train_exam" do
    assert_difference('Exam.count', -1) do
      delete train_exam_url(@train_exam)
    end

    assert_redirected_to train_exams_url
  end
end
