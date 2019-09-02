require 'test_helper'

class TrainHr::My::ExamsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @train_my_exam = train_my_exams(:one)
  end

  test "should get index" do
    get train_my_exams_url
    assert_response :success
  end

  test "should get new" do
    get new_train_my_exam_url
    assert_response :success
  end

  test "should create train_my_exam" do
    assert_difference('Exam.count') do
      post train_my_exams_url, params: { train_my_exam: {  } }
    end

    assert_redirected_to train_my_exam_url(Exam.last)
  end

  test "should show train_my_exam" do
    get train_my_exam_url(@train_my_exam)
    assert_response :success
  end

  test "should get edit" do
    get edit_train_my_exam_url(@train_my_exam)
    assert_response :success
  end

  test "should update train_my_exam" do
    patch train_my_exam_url(@train_my_exam), params: { train_my_exam: {  } }
    assert_redirected_to train_my_exam_url(@train_my_exam)
  end

  test "should destroy train_my_exam" do
    assert_difference('Exam.count', -1) do
      delete train_my_exam_url(@train_my_exam)
    end

    assert_redirected_to train_my_exams_url
  end
end
