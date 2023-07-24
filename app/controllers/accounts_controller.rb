class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  # GET /accounts or /accounts.json
  def index
    @accounts = Account.where(user: params[:user_id]).all
    render json: { data: @accounts, status: :ok}
  end

  # GET /accounts/1 or /accounts/1.json
  def show
    # @expenses = Expense.where()
    render json: { status: :ok }
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts or /accounts.json
  def create

    puts params
    puts
    puts "hello"
    puts account_params

    @user = User.where(id: params[:user_id])
    puts @user

    puts "you here?"
    # expenses = params[:expenses].map {|x| {name: x[:name], amount: x[:amount], date: x[:date], id: x[:id]}}
    expenses = params[:expenses].map {|x| Expense.find_by(id: x[:id])}
    puts expenses
    @account = Account.new(
      name: params[:name],
      start: params[:start],
      total: params[:total],
      end: params[:end],
      user_id: params[:user_id],
      expenses: expenses,
    )

    if @account.save
      for i in expenses do
        puts "in the accounts controller"
        puts i
        @expense = Expense.find_by(id: i[:id])
        puts 
        puts @expense.account_ids 
        puts "hello"
        puts
        # @expense.update(account: @account.id)
      end

      # @account.update(expense_ids: expense_list)
      render json: { status: :created, message: 'Success', id: "#{@account.id}"}
      puts @account.id
    else
      render json: { json: @account.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /accounts/1 or /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to account_url(@account), notice: "Account was successfully updated." }
        format.json { render :show, status: :ok, location: @account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1 or /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :start, :total, :end, :user_id)
    end
end
