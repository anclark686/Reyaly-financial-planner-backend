require 'users_helper'
include UsersHelper

class UsersController < ApplicationController
  before_action :set_user, only: %i[ update destroy ]

  # GET /users or /users.json
  def index
    @users = User.all
    render json: { data: @users, status: :ok, message: 'Success' }, status: :ok
  end

  # GET /users/1 or /users/1.json
  def show
    begin  # "try" block
      @user = User.find_by(uid: params[:id])

      data = {
        user: @user, 
        expenses: get_expenses_list(@user.id), 
        paychecks: get_paychecks_list(@user.id),
        debts: get_debts_list(@user.id),
        accounts: get_accounts_list(@user.id)
      }

      render json: { data: data, status: :ok, message: 'Success' }, status: :ok

    rescue Mongoid::Errors::DocumentNotFound => err
      render json: { status: :not_found, message: 'Not Found' }, status: :not_found
    end
  end

  # POST /users or /users.json
  def create
    if user_params[:uid] 
      @user = User.new(user_params)

      first_paycheck = save_paychecks(user_params[:frequency], user_params[:date], @user)

      begin  # "try" block
        if @user.save
          render json: { status: :created, message: 'Success', id: "#{@user.id}", next: first_paycheck}, status: :created
        else
          render json: { json: @user.errors, status: :unprocessable_entity }, status: :unprocessable_entity
        end
      rescue Mongo::Error::OperationFailure => err
        render json: { status: :not_implemented, message: 'Duplicate'}, status: :not_implemented
      end 
    else
      render json: { status: :not_implemented, message: 'UID required' }, status: :not_implemented
    end
  end


  # PATCH/PUT /users/1 or /users/1.json
  def update

    if @user.date != params[:date] || @user.frequency != params[:frequency]
      @paychecks = Paycheck.where(user: @user).all
      for paycheck in @paychecks do
        paycheck.delete
      end

      UsersHelper.save_paychecks(params[:frequency], params[:date], @user)

    end

    if @user.update(user_params)

      render json: { status: :ok, message: 'Success', id: "#{@user.id}"}
    else
      render json: { json: @user.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # POST /users/1
  def download
    UsersHelper.download_to_excel(params[:data])
    render json: { status: :ok, message: 'Recieved' }, status: :ok
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    
    if @user.destroy
      render json: { status: :ok, message: 'User successfully deleted'}, status: :ok
    else
      render json: { status: :not_found, message: 'User not found'}, status: :not_found
    end
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(
                              :username, 
                              :uid, 
                              :pay, 
                              :rate, 
                              :frequency, 
                              :hours, 
                              :date, 
                              :deductions, 
                              :residence,
                              :relationship
                            )
    end
end
