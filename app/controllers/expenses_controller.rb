class ExpensesController < ApplicationController
  before_action :set_expense, only: %i[ show edit update destroy ]

  # GET /expenses or /expenses.json
  def index
    
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
      puts @expenses

    else
      start_day = Date::strptime(params[:date], "%m/%d/%Y")
      if params[:frequency] == "weekly"
        end_day = start_day + 7.days
      elsif params[:frequency] == "bi-weekly"
        end_day = start_day + 14.days
      end
      
      start_day = start_day.mday
      end_day = end_day.mday

      if end_day > start_day
        @expenses = Expense.where(
          user: params[:user_id],
          :date => {:$gte => start_day, :$lte => end_day}
        ).all
        puts @expenses
      else
        @expenses1 = Expense.where(
          user: params[:user_id],
          :date => {:$gte => start_day, :$lte => 31}
        ).all
        puts @expenses1
        @expenses2 = Expense.where(
          user: params[:user_id],
          :date => {:$gte => 1, :$lte => end_day}
        ).all
        puts @expenses2

        @expenses = @expenses1 + @expenses2
        puts @expenses
      end
    end
    

    render json: { data: @expenses, status: :ok, message: 'Success' }
  end

  # GET /expenses/1 or /expenses/1.json
  def show
  end

  # GET /expenses/new
  def new
    @expense = Expense.new
  end

  # GET /expenses/1/edit
  def edit
  end

  # POST /expenses or /expenses.json
  def create
    puts params
    @expense = Expense.new(
      name: params[:name],
      amount: params[:amount],
      date: params[:date],
      user_id: params[:user_id],
    )
    puts @expense

    if @expense.save
      render json: { status: :ok, message: 'Success', id: "#{@expense.id}"}
      puts @expense.id
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }
    end
  end

  # PATCH/PUT /expenses/1 or /expenses/1.json
  def update
    puts params
    if @expense.update(
        name: params[:name],
        amount: params[:amount],
        date: params[:date],
        user_id: params[:user_id],
      )
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /expenses/1 or /expenses/1.json
  def destroy
    puts params
    @expense.destroy

    render json: { status: :ok, message: 'Success'}
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
