require "test_helper"

class UserTest < ActiveSupport::TestCase
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
  end

  test "Create an new User" do
    puts @user
    assert @user.valid?
  end 
end
