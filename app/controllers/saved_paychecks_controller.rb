require 'json'

class SavedPaychecksController < ApplicationController
  before_action :set_saved_paycheck, only: %i[ show edit update destroy ]

  # GET /saved_paychecks or /saved_paychecks.json
  def index
    @saved_paycheck = SavedPaycheck.find_by(paycheck_id: params[:paycheck_id])
    render json: { data: @saved_paycheck, status: :ok, message: 'Success' }, status: :ok
  end

  # POST /saved_paychecks or /saved_paychecks.json
  def create
    @saved_paycheck = SavedPaycheck.new(
      paycheck_id: params[:paycheckId],
      date: params[:date],
      expenses: params[:expenses].map {|x| x.permit!.to_h},
      user_id: params[:user_id],
    )

    if @saved_paycheck.save
      render json: { status: :created, message: 'Success', id: "#{@saved_paycheck.id}" }, status: :created
    else
      render json: { json: @saved_paycheck.errors, status: :unprocessable_entity }, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /saved_paychecks/1 or /saved_paychecks/1.json
  def update
    if @saved_paycheck.update(
      paycheck_id: params[:paycheckId],
      date: params[:date],
      expenses: params[:expenses].map {|x| x.permit!.to_h},
      user_id: params[:user_id],
    )
    render json: { status: :ok, message: 'Success' }, status: :ok
  else
    render json: { json: @saved_paycheck.errors, status: :unprocessable_entity }, status: :unprocessable_entity
  end
  end

  # DELETE /saved_paychecks/1 or /saved_paychecks/1.json
  def destroy
    @saved_paycheck.destroy

    render json: { status: :ok, message: 'Success'}, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saved_paycheck
      @saved_paycheck = SavedPaycheck.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saved_paycheck_params
      params.require(:saved_paycheck).permit(:paycheck_id, :date)
    end
end
