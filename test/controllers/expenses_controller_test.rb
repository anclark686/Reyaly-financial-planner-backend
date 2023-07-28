require "test_helper"

class ExpensesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.new(
      username: "MyString",
      uid: "MyString",
      pay: 60000.0,
      rate: "annualy",
      frequency: "monthly",
      hours: 80.0,
      date: "2023-06-30",
      deductions: 300,
      residence: "GA",
      relationship: "single"
    )
    @expense = Expense.new(
      user: @user,
      name: "MyString",
      amount: 1,
      date: 1
    )
  end

  test "should get index" do
    get user_expenses_url(@user._id.to_s, frequency: "monthly")
    assert_response :success
  end

  # test "should get new" do
  #   skip("test not ready")
  #   get new_expense_url
  #   assert_response :success
  # end

  # test "should create expense" do
  #   skip("test not ready")
  #   assert_difference("Expense.count") do
  #     post expenses_url, params: { expense: { amount: @expense.amount, date: @expense.date, name: @expense.name, user_id: @expense.user_id } }
  #   end

  #   # assert_redirected_to expense_url(Expense.last)
  # end

  # test "should show expense" do
  #   skip("test not ready")
  #   get expense_url(@expense)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   skip("test not ready")
  #   get edit_expense_url(@expense)
  #   assert_response :success
  # end

  # test "should update expense" do
  #   skip("test not ready")
  #   patch expense_url(@expense), params: { expense: { amount: @expense.amount, date: @expense.date, name: @expense.name, user_id: @expense.user_id } }
  #   assert_redirected_to expense_url(@expense)
  # end

  # test "should destroy expense" do
  #   skip("test not ready")
  #   assert_difference("Expense.count", -1) do
  #     delete expense_url(@expense)
  #   end

  #   # assert_redirected_to expenses_url
  # end
end
