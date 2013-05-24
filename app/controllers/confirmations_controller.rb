class ConfirmationsController < ApplicationController
  before_filter :find_object, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_user, only: [:show, :edit, :update, :destroy]

  def find_object
    @confirmation = Confirmation.find(params[:id])
  end

  def authorize_user
    if @confirmation.user != current_user
      redirect_to confirmations_url, notice: "Nice try."
    end
  end


  # GET /confirmations
  # GET /confirmations.json
  def index
    @confirmations = current_user.confirmations.order("performed_on DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @confirmations }
    end
  end

  # GET /confirmations/1
  # GET /confirmations/1.json
  def show
    @confirmation = Confirmation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @confirmation }
    end
  end

  # GET /confirmations/new
  # GET /confirmations/new.json
  def new
    @confirmation = Confirmation.new
    @confirmation.service_order_id = params[:service_order_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @confirmation }
    end
  end

  # GET /confirmations/1/edit
  def edit
    @confirmation = Confirmation.find(params[:id])
  end

  # POST /confirmations
  # POST /confirmations.json
  def create
    @confirmation = Confirmation.new(params[:confirmation])
    @confirmation.user_id = current_user.id

    respond_to do |format|
      if @confirmation.save
        format.html { redirect_to @confirmation, notice: 'Confirmation was successfully created.' }
        format.json { render json: @confirmation, status: :created, location: @confirmation }
      else
        format.html { render action: "new" }
        format.json { render json: @confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /confirmations/1
  # PUT /confirmations/1.json
  def update
    @confirmation = Confirmation.find(params[:id])

    respond_to do |format|
      if @confirmation.update_attributes(params[:confirmation])
        format.html { redirect_to @confirmation, notice: 'Confirmation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @confirmation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /confirmations/1
  # DELETE /confirmations/1.json
  def destroy
    @confirmation = Confirmation.find(params[:id])
    @confirmation.destroy

    respond_to do |format|
      format.html { redirect_to confirmations_url }
      format.json { head :no_content }
    end
  end
end
