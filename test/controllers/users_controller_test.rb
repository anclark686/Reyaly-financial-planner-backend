require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
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
    DatabaseCleaner.clean
  end

  test "should get index" do
    get users_url

    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { 
        username: @user.username, 
        uid: @user.uid, 
        pay: @user.pay, 
        rate: @user.rate,
        frequency: @user.frequency,
        hours: @user.hours,
        date: @user.date,
        deductions: @user.deductions,
        residence: @user.residence,
        relationship: @user.relationship
        } }
    end
    assert_response :created
  end

  test "should not create user" do
    assert_no_difference("User.count") do
      post users_url, params: { user: { username: @user.username } }
    end
    assert_response :not_implemented
  end

  # test "should update user without paycheck changes" do
  #   patch user_url(@user._id.to_s), params: { user: { 
  #     username: "SomeoneNew", 
  #     uid: @user.uid, 
  #     pay: @user.pay, 
  #     rate: @user.rate,
  #     frequency: @user.frequency,
  #     hours: @user.hours,
  #     date: @user.date,
  #     deductions: @user.deductions,
  #     residence: @user.residence,
  #     relationship: @user.relationship
  #     } }
  #     assert_response :success
  # end

  # test "should update user with paycheck changes" do
  #   patch user_url(@user._id.to_s), params: { user: { 
  #     username: @user.username, 
  #     uid: @user.uid, 
  #     pay: @user.pay, 
  #     rate: @user.rate,
  #     frequency: "bi-monthly",
  #     hours: @user.hours,
  #     date: @user.date,
  #     deductions: @user.deductions,
  #     residence: @user.residence,
  #     relationship: @user.relationship
  #     } }
  #     assert_response :success
  # end

  # test "should destroy user" do
  #   puts user_url(@user._id.to_s)
  #   assert_difference("User.count", -1) do
      
  #     delete user_url(@user._id.to_s)
  #   end
  # end
end
