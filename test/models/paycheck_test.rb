require "test_helper"

class PaycheckTest < ActiveSupport::TestCase
  setup do
    user = User.new(
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
    @paycheck = Paycheck.new(user: user, date: "MyString")
  end

  test "Create an new Paycheck" do
    assert @paycheck.valid?
  end 
end
