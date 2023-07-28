require "test_helper"

class ExpenseTest < ActiveSupport::TestCase
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
    @expense = Expense.new(
      user: user,
      name: "MyString",
      amount: 1,
      date: 1
    )
  end

  test "Create an new Expense" do
    assert @expense.valid?
  end 
end
