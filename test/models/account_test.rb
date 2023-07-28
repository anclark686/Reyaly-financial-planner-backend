require "test_helper"

class AccountTest < ActiveSupport::TestCase
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
    @account = Account.new(
      user: user,
      name: "MyString",
      start: 1.5,
      total: 1.5,
      end: 1.5
    )
  end

  test "Create an new Account" do
    assert @account.valid?
  end  
end
