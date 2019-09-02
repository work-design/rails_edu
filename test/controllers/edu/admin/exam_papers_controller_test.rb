require 'test_helper'

class Train::ExamPapersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @train_exam_paper = train_exam_papers(:one)
  end

  test "should get index" do
    get train_exam_papers_url
    assert_response :success
  end

  test "should get new" do
    get new_train_exam_paper_url
    assert_response :success
  end

  test "should create train_exam_paper" do
    assert_difference('ExamPaper.count') do
      post train_exam_papers_url, params: { train_exam_paper: {  } }
    end

    assert_redirected_to train_exam_paper_url(ExamPaper.last)
  end

  test "should show train_exam_paper" do
    get train_exam_paper_url(@train_exam_paper)
    assert_response :success
  end

  test "should get edit" do
    get edit_train_exam_paper_url(@train_exam_paper)
    assert_response :success
  end

  test "should update train_exam_paper" do
    patch train_exam_paper_url(@train_exam_paper), params: { train_exam_paper: {  } }
    assert_redirected_to train_exam_paper_url(@train_exam_paper)
  end

  test "should destroy train_exam_paper" do
    assert_difference('ExamPaper.count', -1) do
      delete train_exam_paper_url(@train_exam_paper)
    end

    assert_redirected_to train_exam_papers_url
  end
end
