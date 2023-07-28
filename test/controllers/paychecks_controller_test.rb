require "test_helper"

class PaychecksControllerTest < ActionDispatch::IntegrationTest
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
    @paycheck = Paycheck.new(user: @user, date: "2023-06-30")
  end

  # test "should get index" do
  #   get user_paychecks_url(@user._id.to_s)
  #   assert_response :success
  # end

end
