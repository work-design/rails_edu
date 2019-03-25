require "application_system_test_case"

class LessonStudentsTest < ApplicationSystemTestCase
  setup do
    @edu_admin_lesson_student = edu_admin_lesson_students(:one)
  end

  test "visiting the index" do
    visit edu_admin_lesson_students_url
    assert_selector "h1", text: "Lesson Students"
  end

  test "creating a Lesson student" do
    visit edu_admin_lesson_students_url
    click_on "New Lesson Student"

    fill_in "Attended", with: @edu_admin_lesson_student.attended
    fill_in "Created at", with: @edu_admin_lesson_student.created_at
    fill_in "State", with: @edu_admin_lesson_student.state
    fill_in "Student", with: @edu_admin_lesson_student.student
    click_on "Create Lesson student"

    assert_text "Lesson student was successfully created"
    click_on "Back"
  end

  test "updating a Lesson student" do
    visit edu_admin_lesson_students_url
    click_on "Edit", match: :first

    fill_in "Attended", with: @edu_admin_lesson_student.attended
    fill_in "Created at", with: @edu_admin_lesson_student.created_at
    fill_in "State", with: @edu_admin_lesson_student.state
    fill_in "Student", with: @edu_admin_lesson_student.student
    click_on "Update Lesson student"

    assert_text "Lesson student was successfully updated"
    click_on "Back"
  end

  test "destroying a Lesson student" do
    visit edu_admin_lesson_students_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Lesson student was successfully destroyed"
  end
end
