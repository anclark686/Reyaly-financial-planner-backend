class SavedPaychecksController < ApplicationController
  before_action :set_saved_paycheck, only: %i[ show edit update destroy ]

  # GET /saved_paychecks or /saved_paychecks.json
  def index
    @saved_paychecks = SavedPaycheck.all
  end

  # GET /saved_paychecks/1 or /saved_paychecks/1.json
  def show
  end

  # GET /saved_paychecks/new
  def new
    @saved_paycheck = SavedPaycheck.new
  end

  # GET /saved_paychecks/1/edit
  def edit
  end

  # POST /saved_paychecks or /saved_paychecks.json
  def create
    @saved_paycheck = SavedPaycheck.new(saved_paycheck_params)

    respond_to do |format|
      if @saved_paycheck.save
        format.html { redirect_to saved_paycheck_url(@saved_paycheck), notice: "Saved paycheck was successfully created." }
        format.json { render :show, status: :created, location: @saved_paycheck }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saved_paycheck.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /saved_paychecks/1 or /saved_paychecks/1.json
  def update
    respond_to do |format|
      if @saved_paycheck.update(saved_paycheck_params)
        format.html { redirect_to saved_paycheck_url(@saved_paycheck), notice: "Saved paycheck was successfully updated." }
        format.json { render :show, status: :ok, location: @saved_paycheck }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saved_paycheck.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /saved_paychecks/1 or /saved_paychecks/1.json
  def destroy
    @saved_paycheck.destroy

    respond_to do |format|
      format.html { redirect_to saved_paychecks_url, notice: "Saved paycheck was successfully destroyed." }
      format.json { head :no_content }
    end
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
