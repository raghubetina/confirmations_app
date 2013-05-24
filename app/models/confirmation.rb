class Confirmation < ActiveRecord::Base
  attr_accessible :description, :doubletime_hours, :number, :overtime_hours, :performed_on, :service_order_id, :straight_hours, :travel_hours, :user_id, :user, :service_order

  # Associations
  belongs_to :service_order
  belongs_to :user

  # Validations
  validates :doubletime_hours, numericality: true
  validates :number, presence: true
  validates :overtime_hours, numericality: true
  validates :performed_on, presence: true
  validates :straight_hours, numericality: true
  validates :travel_hours, numericality: true
  validates :user, presence: true
end
