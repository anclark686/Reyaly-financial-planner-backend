#heroku run rake send_reminders
require "#{Rails.root}/app/helpers/expenses_helper"
include ExpensesHelper

desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  puts "done."
end

task :send_reminders => :environment do
  puts Date.today.sunday?
  puts Date.today.saturday?

  @users = User.all
  for user in @users do
    start_day = DateTime.now
    end_day = start_day + 7.days
    
    start_day = start_day.mday
    end_day = end_day.mday

    @expenses = ExpensesHelper.get_basic_expenses(start_day, end_day, user.id)

    expense_list = []
    for expense in @expenses do
      formatted_date = ExpensesHelper.get_actual_date(expense.date) 
      expense_item = {name: expense.name, amount: expense.amount, date: formatted_date}
      expense_list.append(expense_item)
    end
    expense_list.sort_by! { |ex| ex["date"] }

    UsersMailer.with(email: user.email, name: user.username, expenses: expense_list).reminder_email.deliver_now
  end
end

