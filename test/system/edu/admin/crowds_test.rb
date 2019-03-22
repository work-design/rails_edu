require "application_system_test_case"

class CrowdsTest < ApplicationSystemTestCase
  setup do
    @edu_admin_crowd = edu_admin_crowds(:one)
  end

  test "visiting the index" do
    visit edu_admin_crowds_url
    assert_selector "h1", text: "Crowds"
  end

  test "creating a Crowd" do
    visit edu_admin_crowds_url
    click_on "New Crowd"

    fill_in "Name", with: @edu_admin_crowd.name
    fill_in "Student type", with: @edu_admin_crowd.student_type
    click_on "Create Crowd"

    assert_text "Crowd was successfully created"
    click_on "Back"
  end

  test "updating a Crowd" do
    visit edu_admin_crowds_url
    click_on "Edit", match: :first

    fill_in "Name", with: @edu_admin_crowd.name
    fill_in "Student type", with: @edu_admin_crowd.student_type
    click_on "Update Crowd"

    assert_text "Crowd was successfully updated"
    click_on "Back"
  end

  test "destroying a Crowd" do
    visit edu_admin_crowds_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Crowd was successfully destroyed"
  end
end
