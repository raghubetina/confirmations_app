class ServiceOrdersController < ApplicationController
  before_filter :find_object, only: [:show, :edit, :update, :destroy]
  before_filter :authorize_user, only: [:show, :edit, :update, :destroy]

  def find_object
    @service_order = ServiceOrder.find(params[:id])
  end

  def authorize_user
    if @service_order.user != current_user
      redirect_to service_orders_url, notice: "Nice try."
    end
  end

  # GET /service_orders
  # GET /service_orders.json
  def index
    @open_service_orders = current_user.service_orders.where(completed: false).order("created_at DESC")
    @closed_service_orders = current_user.service_orders.where(completed: true).order("created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @service_orders }
    end
  end

  # GET /service_orders/1
  # GET /service_orders/1.json
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @service_order }
    end
  end

  # GET /service_orders/new
  # GET /service_orders/new.json
  def new
    @service_order = ServiceOrder.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @service_order }
    end
  end

  # GET /service_orders/1/edit
  def edit
  end

  # POST /service_orders
  # POST /service_orders.json
  def create
    @service_order = ServiceOrder.new(params[:service_order])
    @service_order.user_id = current_user.id

    respond_to do |format|
      if @service_order.save
        format.html { redirect_to @service_order, notice: 'Service order was successfully created.' }
        format.json { render json: @service_order, status: :created, location: @service_order }
      else
        format.html { render action: "new" }
        format.json { render json: @service_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /service_orders/1
  # PUT /service_orders/1.json
  def update
    respond_to do |format|
      if @service_order.update_attributes(params[:service_order])
        format.html { redirect_to @service_order, notice: 'Service order was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @service_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_orders/1
  # DELETE /service_orders/1.json
  def destroy
    @service_order.destroy

    respond_to do |format|
      format.html { redirect_to service_orders_url }
      format.json { head :no_content }
    end
  end
end
