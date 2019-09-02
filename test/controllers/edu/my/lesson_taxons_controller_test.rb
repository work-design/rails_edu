require 'test_helper'

class LessonTaxonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson_taxon = lesson_taxons(:one)
  end

  test "should get index" do
    get lesson_taxons_url
    assert_response :success
  end

  test "should get new" do
    get new_lesson_taxon_url
    assert_response :success
  end

  test "should create lesson_taxon" do
    assert_difference('LessonTaxon.count') do
      post lesson_taxons_url, params: { lesson_taxon: {  } }
    end

    assert_redirected_to lesson_taxon_url(LessonTaxon.last)
  end

  test "should show lesson_taxon" do
    get lesson_taxon_url(@lesson_taxon)
    assert_response :success
  end

  test "should get edit" do
    get edit_lesson_taxon_url(@lesson_taxon)
    assert_response :success
  end

  test "should update lesson_taxon" do
    patch lesson_taxon_url(@lesson_taxon), params: { lesson_taxon: {  } }
    assert_redirected_to lesson_taxon_url(@lesson_taxon)
  end

  test "should destroy lesson_taxon" do
    assert_difference('LessonTaxon.count', -1) do
      delete lesson_taxon_url(@lesson_taxon)
    end

    assert_redirected_to lesson_taxons_url
  end
end
