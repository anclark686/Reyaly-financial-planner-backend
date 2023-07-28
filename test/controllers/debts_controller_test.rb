require "test_helper"

class DebtsControllerTest < ActionDispatch::IntegrationTest
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
    @debt = Debt.new(
      user: @user,
      name: "MyString",
      type: "MyString",
      owed: 1.5,
      limit: 1,
      rate: 1.5,
      payment: 1.5
    )
  end

  test "should get index" do
    get user_debts_url(@user._id.to_s)
    assert_response :success
  end

  # test "should get new" do
  #   skip("test not ready")
  #   get new_debt_url
  #   assert_response :success
  # end

  # test "should create debt" do
  #   skip("test not ready")
  #   assert_difference("Debt.count") do
  #     post debts_url, params: { debt: { limit: @debt.limit, owed: @debt.owed, payment: @debt.payment, rate: @debt.rate, user_id: @debt.user_id } }
  #   end

  #   assert_redirected_to debt_url(Debt.last)
  # end

  # test "should show debt" do
  #   skip("test not ready")
  #   get debt_url(@debt)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   skip("test not ready")
  #   get edit_debt_url(@debt)
  #   assert_response :success
  # end

  # test "should update debt" do
  #   skip("test not ready")
  #   patch debt_url(@debt), params: { debt: { limit: @debt.limit, owed: @debt.owed, payment: @debt.payment, rate: @debt.rate, user_id: @debt.user_id } }
  #   assert_redirected_to debt_url(@debt)
  # end

  # test "should destroy debt" do
  #   skip("test not ready")
  #   assert_difference("Debt.count", -1) do
  #     delete debt_url(@debt)
  #   end

  #   assert_redirected_to debts_url
  # end
end
