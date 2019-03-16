require "application_system_test_case"

class LessonsTest < ApplicationSystemTestCase
  setup do
    @edu_admin_lesson = edu_admin_lessons(:one)
  end

  test "visiting the index" do
    visit edu_admin_lessons_url
    assert_selector "h1", text: "Lessons"
  end

  test "creating a Lesson" do
    visit edu_admin_lessons_url
    click_on "New Lesson"

    fill_in "Documents", with: @edu_admin_lesson.documents
    fill_in "Title", with: @edu_admin_lesson.title
    fill_in "Videos", with: @edu_admin_lesson.videos
    click_on "Create Lesson"

    assert_text "Lesson was successfully created"
    click_on "Back"
  end

  test "updating a Lesson" do
    visit edu_admin_lessons_url
    click_on "Edit", match: :first

    fill_in "Documents", with: @edu_admin_lesson.documents
    fill_in "Title", with: @edu_admin_lesson.title
    fill_in "Videos", with: @edu_admin_lesson.videos
    click_on "Update Lesson"

    assert_text "Lesson was successfully updated"
    click_on "Back"
  end

  test "destroying a Lesson" do
    visit edu_admin_lessons_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lesson was successfully destroyed"
  end
end
