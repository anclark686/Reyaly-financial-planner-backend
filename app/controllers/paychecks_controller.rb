class PaychecksController < ApplicationController
  before_action :set_paycheck, only: %i[ show edit update destroy ]

  # GET /paychecks or /paychecks.json
  def index
    @paychecks = Paycheck.where(user: params[:id]).all
  end

  # GET /paychecks/1 or /paychecks/1.json
  def show
  end

  # GET /paychecks/new
  def new
    @paycheck = Paycheck.new
  end

  # GET /paychecks/1/edit
  def edit
  end

  # POST /paychecks or /paychecks.json
  def create
    @paycheck = Paycheck.new(paycheck_params)

    respond_to do |format|
      if @paycheck.save
        format.html { redirect_to paycheck_url(@paycheck), notice: "Paycheck was successfully created." }
        format.json { render :show, status: :created, location: @paycheck }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @paycheck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paychecks/1 or /paychecks/1.json
  def update
    respond_to do |format|
      if @paycheck.update(paycheck_params)
        format.html { redirect_to paycheck_url(@paycheck), notice: "Paycheck was successfully updated." }
        format.json { render :show, status: :ok, location: @paycheck }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @paycheck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paychecks/1 or /paychecks/1.json
  def destroy
    @paycheck.destroy

    respond_to do |format|
      format.html { redirect_to paychecks_url, notice: "Paycheck was successfully destroyed." }
      format.json { head :no_content }
    end
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
