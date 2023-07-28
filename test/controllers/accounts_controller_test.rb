require "test_helper"

class AccountsControllerTest < ActionDispatch::IntegrationTest
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
    @account = Account.new(
      user: @user,
      name: "MyString",
      start: 1.5,
      total: 1.5,
      end: 1.5
    )
  end

  test "should get index" do
    get user_accounts_url(@user._id.to_s)
    assert_response :success
  end

  # test "should create account" do
  #   skip("test not ready")
  #   assert_difference("Account.count") do
  #     post accounts_url, params: { account: { end: @account.end, name: @account.name, start: @account.start, total: @account.total, user_id: @account.user_id } }
  #   end

  #   # assert_redirected_to account_url(Account.last)
  # end

  # test "should show account" do
  #   skip("test not ready")
  #   get account_url(@account)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   skip("test not ready")
  #   get edit_account_url(@account)
  #   assert_response :success
  # end

  # test "should update account" do
  #   skip("test not ready")
  #   patch account_url(@account), params: { account: { end: @account.end, name: @account.name, start: @account.start, total: @account.total, user_id: @account.user_id } }
  #   # assert_redirected_to account_url(@account)
  # end

  # test "should destroy account" do
  #   skip("test not ready")
  #   assert_difference("Account.count", -1) do
  #     delete account_url(@account)
  #   end

  #   assert_redirected_to accounts_url
  # end
end
