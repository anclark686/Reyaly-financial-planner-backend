class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]

  # GET /users or /users.json
  def index
    @user = User.where(uid: params[:uid])
    if @user.length() == 1
      render json: { data: @user, status: :ok, message: 'Success' }
    else
      render json: { status: :not_found, message: 'Not Found' }
    end
  end

  # GET /users/1 or /users/1.json
  def show
    puts "hello"
    @user = User.find(uid: params[:id])
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
    puts "hello"
    puts params
    user_params = 
    @user = User.new(
      username: params[:userName],
      uid: params[:uid],
      pay: params[:pay],
      pay_rate: params[:rate],
      pay_freq: params[:frequncy],
    )

    begin  # "try" block
      if @user.save
        render json: { status: :ok, message: 'Success', id: "#{@user.id}"}
        puts @user.id
      else
        render json: { json: @user.errors, status: :unprocessable_entity }
      end
    rescue Mongo::Error::OperationFailure => err
      render json: { status: :not_implemented, message: 'Duplicate'}

    end 



  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
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
