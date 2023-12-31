require 'expenses_helper'
include ExpensesHelper

require 'users_helper'
include UsersHelper

class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ update destroy ]

  # GET /expenses or /expenses.json
  def index
    if params[:frequency]
      if params[:frequency] == "monthly"
        @expenses = Expense.where(user: params[:user_id]).all

      elsif params[:frequency] == "bi-monthly"
        start_day = Date::strptime(params[:date], "%m/%d/%Y").mday

        if start_day == 1
          end_day = 15
        else
          end_day = 31
        end

        @expenses = Expense.where(
          user: params[:user_id],
          :date => {:$gte => start_day, :$lte => end_day}
        ).all

      else
        start_day = Date::strptime(params[:date], "%m/%d/%Y")
        if params[:frequency] == "weekly"
          end_day = start_day + 7.days
        elsif params[:frequency] == "bi-weekly"
          end_day = start_day + 14.days
        end
        
        start_day = start_day.mday
        end_day = end_day.mday

        @expenses = ExpensesHelper.get_basic_expenses(start_day, end_day, params[:user_id])
      end  
    else 
      start_day = Date::strptime(params[:date1], "%m/%d/%Y").mday
      end_day = Date::strptime(params[:date2], "%m/%d/%Y").mday

      @expenses = ExpensesHelper.get_basic_expenses(start_day, end_day, params[:user_id])
    end  

    expenses_list = []
      for i in @expenses do
          expenses_list.append(UsersHelper.clean_expense(i))
      end

    render json: { data: expenses_list, status: :ok, message: 'Success' }, status: :ok
  end

  # POST /expenses or /expenses.json
  def create
    @expense = Expense.new(
      name: params[:name],
      amount: params[:amount],
      date: params[:date],
      user_id: params[:user_id],
    )

    if @expense.save
      render json: { status: :created, message: 'Success', id: "#{@expense.id}"}, status: :created
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    if @expense.update(
        name: params[:name],
        amount: params[:amount],
        date: params[:date],
        user_id: params[:user_id],
      )
      render json: { status: :ok, message: 'Success' }, status: :ok
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    begin
      @account = Account.find_by(id: @expense.account_ids[0])
      @account.pull(expense_ids: @expense._id)
    rescue Mongoid::Errors::DocumentNotFound => err
      puts err
    end  
    @expense.destroy

    render json: { status: :ok, message: 'Success'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_expense
      @expense = Expense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def expense_params
      params.require(:expense).permit(:name, :amount, :date, :user_id)
    end
end
