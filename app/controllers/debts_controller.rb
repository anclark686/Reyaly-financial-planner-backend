class DebtsController < ApplicationController
  before_action :set_debt, only: %i[ update destroy ]

  # GET /debts or /debts.json
  def index
    @debts = Debt.where(user: params[:id]).all
    render json: { data: @debts, status: :ok}, status: :ok
  end


  # POST /debts or /debts.json
  def create

    @debt = Debt.new(
      name: params[:name],
      type: params[:type],
      owed: params[:owed],
      limit: params[:limit],
      rate: params[:rate],
      payment: params[:payment],
      user_id: params[:user_id],
    )

    if @debt.save
      render json: { status: :created, message: 'Success', id: "#{@debt.id}"}, status: :created
    else
      render json: { json: @debt.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /debts/1 or /debts/1.json
  def update

    if @debt.update(
        name: params[:name],
        type: params[:type],
        owed: params[:owed],
        limit: params[:limit],
        rate: params[:rate],
        payment: params[:payment],
        user_id: params[:user_id],
      )
      render json: { status: :ok, message: 'Success' }, status: :ok
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # DELETE /debts/1 or /debts/1.json
  def destroy

    @debt.destroy

    render json: { status: :ok, message: 'Success'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_debt
      @debt = Debt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def debt_params
      params.require(:debt).permit(:name, :type, :owed, :limit, :rate, :payment, :user_id)
    end
end
