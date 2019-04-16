require "application_system_test_case"

class CoursePlansTest < ApplicationSystemTestCase
  setup do
    @edu_admin_course_plan = edu_admin_course_plans(:one)
  end

  test "visiting the index" do
    visit edu_admin_course_plans_url
    assert_selector "h1", text: "Course Plans"
  end

  test "creating a Course plan" do
    visit edu_admin_course_plans_url
    click_on "New Course Plan"

    fill_in "Booking on", with: @edu_admin_course_plan.booking_on
    fill_in "Lesson", with: @edu_admin_course_plan.lesson
    click_on "Create Course plan"

    assert_text "Course plan was successfully created"
    click_on "Back"
  end

  test "updating a Course plan" do
    visit edu_admin_course_plans_url
    click_on "Edit", match: :first

    fill_in "Booking on", with: @edu_admin_course_plan.booking_on
    fill_in "Lesson", with: @edu_admin_course_plan.lesson
    click_on "Update Course plan"

    assert_text "Course plan was successfully updated"
    click_on "Back"
  end

  test "destroying a Course plan" do
    visit edu_admin_course_plans_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Course plan was successfully destroyed"
  end
end
