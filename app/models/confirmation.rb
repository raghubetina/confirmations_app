class Confirmation < ActiveRecord::Base
  attr_accessible :description, :doubletime_hours, :number, :overtime_hours, :performed_on, :service_order_id, :straight_hours, :travel_hours, :user_id
end
