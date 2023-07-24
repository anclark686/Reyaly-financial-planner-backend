require 'users_helper'
include UsersHelper

class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    begin  # "try" block
      @user = User.find_by(uid: params[:uid])

      data = {
        user: @user, 
        expenses: get_expenses_list(@user.id), 
        paychecks: get_paychecks_list(@user.id),
        debts: get_debts_list(@user.id),
        accounts: get_accounts_list(@user.id)
      }

      render json: { data: data, status: :ok, message: 'Success' }

    rescue Mongoid::Errors::DocumentNotFound => err
      render json: { status: :not_found, message: 'Not Found' }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    render json: { status: :ok, message: 'Success', data: @user }
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
    @user = User.new(user_params)

    first_paycheck = UsersHelper.save_paychecks(params[:frequency], params[:date], @user)

    begin  # "try" block
      if @user.save
        render json: { status: :created, message: 'Success', id: "#{@user.id}", next: first_paycheck}
      else
        render json: { json: @user.errors, status: :unprocessable_entity }
      end
    rescue Mongo::Error::OperationFailure => err
      render json: { status: :not_implemented, message: 'Duplicate'}
    end 
  end


  # PATCH/PUT /users/1 or /users/1.json
  def update

    if @user.date != params[:date] || @user.pay_freq != params[:frequency]
      @paychecks = Paycheck.where(user: @user).all
      for paycheck in @paychecks do
        paycheck.delete
      end

      UsersHelper.save_paychecks(params[:frequency], params[:date], @user)

    end

    if @user.update(user_params)

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
      params.require(:user).permit(:username, :uid, :pay, :rate, :frequency, :hours, :date, :deductions)
    end
end
