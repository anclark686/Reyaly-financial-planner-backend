class UsersMailer < ApplicationMailer
  def welcome_email
    @email = params[:email]
    @name = params[:name]
    @url  = 'https://www.reyaly-financial-planner.link'
    mail(to: @email, subject: 'Welcome to Reyaly Financial Planner!')
  end

  def reminder_email
    @email = params[:email]
    @expenses = params[:expemses]
    @url = 'https://www.reyaly-financial-planner.link/views/paycheck'
    mail(to: @email, subject: '📅 Weekly Expense Reminder 💵')
  end
end
