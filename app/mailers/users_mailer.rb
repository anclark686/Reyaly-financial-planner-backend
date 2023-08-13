class UsersMailer < ApplicationMailer
  def welcome_email
    @email = params[:email]
    @name = params[:name]
    @url  = 'https://www.reyaly-financial-planner.link'
    mail(to: @email, subject: 'Welcome to Reyaly Financial Planner!')
  end

  def update_email
    @email = params[:email]
    @name = params[:name]
    @url  = 'https://www.reyaly-financial-planner.link/settings'
    mail(to: @email, subject: 'Information Updated for Reyaly Financial Planner')
  end

  def reminder_email
    @email = params[:email]
    @name = params[:name]
    @expenses = params[:expenses]
    @url = 'https://www.reyaly-financial-planner.link/views/calendar'
    mail(to: @email, subject: '📅 Weekly Expense Reminder 💵')
  end
end
