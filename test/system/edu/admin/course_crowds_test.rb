require "application_system_test_case"

class CourseCrowdsTest < ApplicationSystemTestCase
  setup do
    @edu_admin_course_crowd = edu_admin_course_crowds(:one)
  end

  test "visiting the index" do
    visit edu_admin_course_crowds_url
    assert_selector "h1", text: "Course Crowds"
  end

  test "creating a Course crowd" do
    visit edu_admin_course_crowds_url
    click_on "New Course Crowd"

    click_on "Create Course crowd"

    assert_text "Course crowd was successfully created"
    click_on "Back"
  end

  test "updating a Course crowd" do
    visit edu_admin_course_crowds_url
    click_on "Edit", match: :first

    click_on "Update Course crowd"

    assert_text "Course crowd was successfully updated"
    click_on "Back"
  end

  test "destroying a Course crowd" do
    visit edu_admin_course_crowds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course crowd was successfully destroyed"
  end
end
