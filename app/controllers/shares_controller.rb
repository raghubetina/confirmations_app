class SharesController < ApplicationController
  before_filter :must_have_service_order, only: [:new]
  before_filter :authorize_user, only: [:destroy]

  def must_have_service_order
    service_order = ServiceOrder.find_by_id(params[:service_order_id])
    if service_order.blank?
      redirect_to root_url, flash: { error: "Service order number required." }
    end
  end

  def authorize_user
    @share = Share.find(params[:id])
    if @share.service_order.user != current_user
      redirect_to :back, flash: { error: "You can only manage sharing for your own service orders." }
    end
  end

  # GET /shares/new
  # GET /shares/new.json
  def new
    @share = Share.new
    @share.service_order_id = params[:service_order_id]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @share }
    end
  end

  # POST /shares
  # POST /shares.json
  def create
    @share = Share.new(params[:share])

    if @share.service_order.user != current_user
      redirect_to :back, flash: { error: "You can only manage sharing for your own service orders." }
      return
    end

    respond_to do |format|
      if @share.save
        format.html { redirect_to @share.service_order, notice: 'Service order shared successfully.' }
        format.json { render json: @share, status: :created, location: @share }
      else
        format.html { render action: "new" }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shares/1
  # DELETE /shares/1.json
  def destroy
    @share = Share.find(params[:id])
    @share.destroy

    respond_to do |format|
      format.html { redirect_to @share.service_order }
      format.json { head :no_content }
    end
  end
end
