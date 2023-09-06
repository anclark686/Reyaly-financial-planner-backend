require "application_system_test_case"

class SavedPaychecksTest < ApplicationSystemTestCase
  setup do
    @saved_paycheck = saved_paychecks(:one)
  end

  test "visiting the index" do
    visit saved_paychecks_url
    assert_selector "h1", text: "Saved paychecks"
  end

  test "should create saved paycheck" do
    visit saved_paychecks_url
    click_on "New saved paycheck"

    fill_in "Date", with: @saved_paycheck.date
    fill_in "Paycheck", with: @saved_paycheck.paycheck_id
    click_on "Create Saved paycheck"

    assert_text "Saved paycheck was successfully created"
    click_on "Back"
  end

  test "should update Saved paycheck" do
    visit saved_paycheck_url(@saved_paycheck)
    click_on "Edit this saved paycheck", match: :first

    fill_in "Date", with: @saved_paycheck.date
    fill_in "Paycheck", with: @saved_paycheck.paycheck_id
    click_on "Update Saved paycheck"

    assert_text "Saved paycheck was successfully updated"
    click_on "Back"
  end

  test "should destroy Saved paycheck" do
    visit saved_paycheck_url(@saved_paycheck)
    click_on "Destroy this saved paycheck", match: :first

    assert_text "Saved paycheck was successfully destroyed"
  end
end
