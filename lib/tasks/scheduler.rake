#heroku run rake send_reminders
require "#{Rails.root}/app/helpers/users_helper"
include UsersHelper

desc "This task is called by the Heroku scheduler add-on"

task :update_feed => :environment do
  puts "Updating feed..."
  puts "done."
end

task :send_reminders => :environment do
  @users = User.all
  for user in @users do
    puts "hello"
    puts user
    UsersMailer.with(email: @user.email, name: @user.username).welcome_email.deliver_later
  end
end

