require "application_system_test_case"

class PaychecksTest < ApplicationSystemTestCase
  setup do
    @paycheck = paychecks(:one)
  end

  test "visiting the index" do
    visit paychecks_url
    assert_selector "h1", text: "Paychecks"
  end

  test "should create paycheck" do
    visit paychecks_url
    click_on "New paycheck"

    fill_in "Date", with: @paycheck.date
    fill_in "User", with: @paycheck.user_id
    click_on "Create Paycheck"

    assert_text "Paycheck was successfully created"
    click_on "Back"
  end

  test "should update Paycheck" do
    visit paycheck_url(@paycheck)
    click_on "Edit this paycheck", match: :first

    fill_in "Date", with: @paycheck.date
    fill_in "User", with: @paycheck.user_id
    click_on "Update Paycheck"

    assert_text "Paycheck was successfully updated"
    click_on "Back"
  end

  test "should destroy Paycheck" do
    visit paycheck_url(@paycheck)
    click_on "Destroy this paycheck", match: :first

    assert_text "Paycheck was successfully destroyed"
  end
end
