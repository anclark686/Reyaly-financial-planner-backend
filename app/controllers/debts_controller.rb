class DebtsController < ApplicationController
  before_action :set_debt, only: %i[ show edit update destroy ]

  # GET /debts or /debts.json
  def index
    @debts = Debt.where(user: params[:id]).all
    puts @debts
  end

  # GET /debts/1 or /debts/1.json
  def show
  end

  # GET /debts/new
  def new
    @debt = Debt.new
  end

  # GET /debts/1/edit
  def edit
  end

  # POST /debts or /debts.json
  def create
    puts params
    puts
    puts "hello"
    puts debt_params

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
      render json: { status: :created, message: 'Success', id: "#{@debt.id}"}
      puts @debt.id
    else
      render json: { json: @debt.errors, status: :unprocessable_entity }
    end

  end

  # PATCH/PUT /debts/1 or /debts/1.json
  def update
    puts "hello"
    puts params

    if @debt.update(
        name: params[:name],
        type: params[:type],
        owed: params[:owed],
        limit: params[:limit],
        rate: params[:rate],
        payment: params[:payment],
        user_id: params[:user_id],
      )
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @expense.errors, status: :unprocessable_entity }
    end
  end

  # DELETE /debts/1 or /debts/1.json
  def destroy
    puts "goodbye"
    puts params
    @debt.destroy

    render json: { status: :ok, message: 'Success'}
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
