require "application_system_test_case"

class OneTimeExpensesTest < ApplicationSystemTestCase
  setup do
    @one_time_expense = one_time_expenses(:one)
  end

  test "visiting the index" do
    visit one_time_expenses_url
    assert_selector "h1", text: "One time expenses"
  end

  test "should create one time expense" do
    visit one_time_expenses_url
    click_on "New one time expense"

    fill_in "Amount", with: @one_time_expense.amount
    fill_in "Date", with: @one_time_expense.date
    fill_in "Name", with: @one_time_expense.name
    click_on "Create One time expense"

    assert_text "One time expense was successfully created"
    click_on "Back"
  end

  test "should update One time expense" do
    visit one_time_expense_url(@one_time_expense)
    click_on "Edit this one time expense", match: :first

    fill_in "Amount", with: @one_time_expense.amount
    fill_in "Date", with: @one_time_expense.date
    fill_in "Name", with: @one_time_expense.name
    click_on "Update One time expense"

    assert_text "One time expense was successfully updated"
    click_on "Back"
  end

  test "should destroy One time expense" do
    visit one_time_expense_url(@one_time_expense)
    click_on "Destroy this one time expense", match: :first

    assert_text "One time expense was successfully destroyed"
  end
end
