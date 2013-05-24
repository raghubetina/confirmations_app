class ServiceOrdersController < ApplicationController
  # GET /service_orders
  # GET /service_orders.json
  def index
    @service_orders = ServiceOrder.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @service_orders }
    end
  end

  # GET /service_orders/1
  # GET /service_orders/1.json
  def show
    @service_order = ServiceOrder.find(params[:id])

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
    @service_order = ServiceOrder.find(params[:id])
  end

  # POST /service_orders
  # POST /service_orders.json
  def create
    @service_order = ServiceOrder.new(params[:service_order])

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
    @service_order = ServiceOrder.find(params[:id])

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
    @service_order = ServiceOrder.find(params[:id])
    @service_order.destroy

    respond_to do |format|
      format.html { redirect_to service_orders_url }
      format.json { head :no_content }
    end
  end
end
