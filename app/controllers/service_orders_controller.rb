class ServiceOrdersController < ApplicationController
  before_filter :find_object, only: [:show, :edit, :update, :destroy]
  before_filter :owner, only: [:edit, :update, :destroy]
  before_filter :viewer, only: [:show]

  def find_object
    @service_order = ServiceOrder.find(params[:id])
  end

  def owner
    if @service_order.user != current_user
      redirect_to :back, flash: { error: "You are not authorized to manage this service order." }
    end
  end

  def viewer
    if !(@service_order.viewers.include? current_user) && @service_order.user != current_user
      redirect_to :back, flash: { error: "You are not authorized to view this service order." }
    end
  end

  # GET /service_orders
  # GET /service_orders.json
  def index
    @open_service_orders = current_user.service_orders.where(completed: false).order("created_at DESC")
    @closed_service_orders = current_user.service_orders.where(completed: true).order("created_at DESC")
    @shared_service_orders = current_user.viewable.order("created_at DESC")

    @today = Date.today
    first_day_of_month = @today.beginning_of_month
    last_day_of_month = @today.end_of_month

    weekdays = @today.downto(first_day_of_month).count { |day| (1..5).include?(day.wday) }

    @workable_hours = weekdays * 8

    this_months_confirmations = current_user.confirmations.where("performed_on >= ? AND performed_on <= ?",
      first_day_of_month, last_day_of_month)

    @this_months_raw_hours = this_months_confirmations.map(&:raw_hours).reduce(&:+)

    if @workable_hours > 0
      @utilization = ((@this_months_raw_hours.to_f / @workable_hours) * 100).round
    else
      @utilization = 0
    end

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
        format.html { redirect_to service_orders_url, notice: 'Service order was successfully created.' }
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
        format.html { redirect_to service_orders_url, notice: 'Service order was successfully updated.' }
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
