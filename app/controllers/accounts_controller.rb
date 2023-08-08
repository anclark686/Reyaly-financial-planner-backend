require 'accounts_helper'
require 'users_helper'

include AccountsHelper
include UsersHelper

class AccountsController < ApplicationController
  before_action :set_account, only: %i[ update destroy ]

  # GET /accounts or /accounts.json
  def index
    accounts = get_accounts_list(params[:user_id])
    render json: { data: accounts, status: :ok}, status: :ok
  end


  # POST /accounts or /accounts.json
  def create
    expenses = params[:expenses].map {|x| Expense.find_by(id: x[:id])}

    @account = Account.new(
      name: params[:name],
      start: params[:start],
      total: params[:total],
      end: params[:end],
      user_id: params[:user_id],
      expenses: expenses,
    )

    if @account.save
      clean_other_accounts(@account, expenses)

      render json: { status: :created, message: 'Success', id: "#{@account.id}"}, status: :created
    else
      render json: { json: @account.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    puts params
    expenses = params[:expenses].map {|x| Expense.find_by(id: x[:id])}

    if @account.update({
                        name: params[:name],
                        start: params[:start],
                        total: params[:total],
                        end: params[:end],
                        user_id: params[:user_id],
                        expenses: expenses,
                      })
                      
      clean_other_accounts(@account, expenses)
      render json: { status: :ok, message: 'Success'}
    else
      render json: { json: @account.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
    # to come
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    for expense in @account.expenses do
      expense.pull(account_ids: @account._id)
    end

    @account.destroy

    render json: { status: :ok, message: 'Account successfully deleted'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end
end
