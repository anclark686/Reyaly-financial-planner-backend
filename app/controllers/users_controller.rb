require 'users_helper'
include UsersHelper

class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    puts params
    @user = User.where(uid: params[:uid])
    if @user.length() == 1
      puts @user[0].id
      @expenses = Expense.where(user: @user[0].id).all
      puts @expenses.length

      expensesList = []
      for i in @expenses
        id = i._id.to_s
        expensesList.append({name: i.name, amount: i.amount, date: i.date, id: id})
      end

      @paychecks = Paycheck.where(user: @user[0].id).all
      puts @paychecks.length

      paychecksList = []
      for i in @paychecks
        id = i._id.to_s
        paychecksList.append({date: i.date, id: id})
      end

      data = {user: @user[0], expenses: expensesList, paychecks: paychecksList}

      render json: { data: data, status: :ok, message: 'Success' }
    else
      render json: { status: :not_found, message: 'Not Found' }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    puts "hello"
    @user = User.where(uid: params[:uid])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end


  # POST /users or /users.json
  def create
    @user = User.new(
      username: params[:userName],
      uid: params[:uid],
      pay: params[:pay],
      pay_rate: params[:rate],
      pay_freq: params[:frequency],
      hours: params[:hours],
      date: params[:date],
      deductions: params[:deductions],
    )

    # 5 years worth
    if params[:frequency] == "weekly"
      num_weeks = 260 
    elsif params[:frequency] == "bi-weekly"
      num_weeks = 130
    elsif params[:frequency] == "monthly"
      num_weeks = 60
    else
      num_weeks = 120
    end

    pay_date = params[:date]
    for a in 1..num_weeks do
      pay_date = UsersHelper.get_next_paycheck(pay_date, params[:frequency])
      @paycheck = Paycheck.new(
        date: pay_date,
        user_id: @user,
      )

      if @paycheck.save
        puts "paycheck added"
      else 
        if @paycheck.errors.any?
          @paycheck.errors.full_messages.each do |message|
            puts message
          end
        end
      end
    end

    begin  # "try" block
      if @user.save
        render json: { status: :ok, message: 'Success', id: "#{@user.id}"}
      else
        render json: { json: @user.errors, status: :unprocessable_entity }
      end
    rescue Mongo::Error::OperationFailure => err
      render json: { status: :not_implemented, message: 'Duplicate'}
    end 
  end


  # PATCH/PUT /users/1 or /users/1.json
  def update
    puts params
    puts 
    puts @user.date == params[:date]
    puts @user.pay_freq == params[:frequency]
    puts 

    if @user.date != params[:date] || @user.pay_freq != params[:frequency]
      @paychecks = Paycheck.where(user: @user).all
      for paycheck in @paychecks do
        paycheck.delete
      end

      # 5 years worth
    if params[:frequency] == "weekly"
      num_weeks = 260 
    elsif params[:frequency] == "bi-weekly"
      num_weeks = 130
    elsif params[:frequency] == "monthly"
      num_weeks = 60
    else
      num_weeks = 120
    end

      pay_date = params[:date]
      for a in 1..num_weeks do
        pay_date = UsersHelper.get_next_paycheck(pay_date, params[:frequency])
        @paycheck = Paycheck.new(
          date: pay_date,
          user_id: @user,
        )

        if @paycheck.save
          puts "paycheck added"
        else 
          if @paycheck.errors.any?
            @paycheck.errors.full_messages.each do |message|
              puts message
            end
          end
        end
      end
    end

    if @user.update(
      username: params[:userName],
      uid: params[:uid],
      pay: params[:pay],
      pay_rate: params[:rate],
      pay_freq: params[:frequency],
      hours: params[:hours],
      date: params[:date],
      deductions: params[:deductions],
    )

      render json: { status: :ok, message: 'Success', id: "#{@user.id}"}
    else
      render json: { json: @user.errors, status: :unprocessable_entity }
    end
  end

  # POST /users/1
  def download
    UsersHelper.download_to_excel(params[:data])
    render json: { status: :ok, message: 'Recieved' }
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :uid, :pay, :pay_rate, :pay_freq)
    end
end
