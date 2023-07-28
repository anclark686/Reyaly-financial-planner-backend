require "test_helper"

class DebtTest < ActiveSupport::TestCase
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
    @debt = Debt.new(
      user: user,
      name: "MyString",
      type: "MyString",
      owed: 1.5,
      limit: 1,
      rate: 1.5,
      payment: 1.5
    )
  end

  test "Create an new Debt" do
    assert @debt.valid?
  end 
end
