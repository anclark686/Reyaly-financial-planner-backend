class OneTimeExpensesController < ApplicationController
  before_action :set_one_time_expense, only: %i[ show edit update destroy ]

  # GET /one_time_expenses or /one_time_expenses.json
  def index
    puts params
    @one_time_expenses = OneTimeExpense.where(paycheck_id: params[:paycheck_id]).all
    render json: { data: @one_time_expenses, status: :ok, message: 'Success' }, status: :ok
  end

  # GET /one_time_expenses/1 or /one_time_expenses/1.json
  def show
  end


  # POST /one_time_expenses or /one_time_expenses.json
  def create
    puts params
    @one_time_expense = OneTimeExpense.new(
                                          name: params[:name],
                                          amount: params[:amount],
                                          date: params[:date],
                                          user_id: params[:user_id],
                                          paycheck_id: params[:paycheck],
                                        )

    if @one_time_expense.save
      render json: { status: :created, message: 'Success', id: "#{@one_time_expense.id}" }, status: :created
    else 
      render json: { json: @one_time_expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /one_time_expenses/1 or /one_time_expenses/1.json
  def update
    puts params

    if params[:newPaycheck] == params[:paycheck]
      if @one_time_expense.update(
              name: params[:name],
              amount: params[:amount],
              date: params[:date],
            )
        render json: { status: :ok, message: 'Success' }, status: :ok
      else
        render json: { json: @expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
      end
    else
      if @one_time_expense.update(
              name: params[:name],
              amount: params[:amount],
              date: params[:date],
              paycheck_id: params[:newPaycheck]
            )
        render json: { status: :ok, message: 'Success' }, status: :ok
      else
        render json: { json: @expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
      end
    end
  end

  # DELETE /one_time_expenses/1 or /one_time_expenses/1.json
  def destroy
    @one_time_expense.destroy

    render json: { status: :ok, message: 'Success'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_one_time_expense
      @one_time_expense = OneTimeExpense.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def one_time_expense_params
      params.require(:one_time_expense).permit(:name, :amount, :date, :paycheck)
    end
end
