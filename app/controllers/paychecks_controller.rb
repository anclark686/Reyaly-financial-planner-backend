class PaychecksController < ApplicationController
  before_action :set_paycheck

  # GET /paychecks or /paychecks.json
  def index
    @paychecks = Paycheck.where(user: params[:id]).all
    render json: { data: @paychecks, status: :ok }, status: :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_paycheck
      @paycheck = Paycheck.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def paycheck_params
      params.require(:paycheck).permit(:date, :user_id)
    end
end
