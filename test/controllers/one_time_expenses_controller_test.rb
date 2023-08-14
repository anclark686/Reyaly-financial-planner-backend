require "test_helper"

class OneTimeExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @one_time_expense = one_time_expenses(:one)
  end

  test "should get index" do
    get one_time_expenses_url
    assert_response :success
  end

  test "should get new" do
    get new_one_time_expense_url
    assert_response :success
  end

  test "should create one_time_expense" do
    assert_difference("OneTimeExpense.count") do
      post one_time_expenses_url, params: { one_time_expense: { amount: @one_time_expense.amount, date: @one_time_expense.date, name: @one_time_expense.name } }
    end

    assert_redirected_to one_time_expense_url(OneTimeExpense.last)
  end

  test "should show one_time_expense" do
    get one_time_expense_url(@one_time_expense)
    assert_response :success
  end

  test "should get edit" do
    get edit_one_time_expense_url(@one_time_expense)
    assert_response :success
  end

  test "should update one_time_expense" do
    patch one_time_expense_url(@one_time_expense), params: { one_time_expense: { amount: @one_time_expense.amount, date: @one_time_expense.date, name: @one_time_expense.name } }
    assert_redirected_to one_time_expense_url(@one_time_expense)
  end

  test "should destroy one_time_expense" do
    assert_difference("OneTimeExpense.count", -1) do
      delete one_time_expense_url(@one_time_expense)
    end

    assert_redirected_to one_time_expenses_url
  end
end
