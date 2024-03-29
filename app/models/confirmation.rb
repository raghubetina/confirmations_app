class Confirmation < ActiveRecord::Base
  attr_accessible :description, :doubletime_hours, :number, :overtime_hours, :performed_on, :service_order_id, :straight_hours, :travel_hours, :user_id, :user, :service_order

  # Associations
  belongs_to :service_order
  belongs_to :user

  # Validations
  validates :doubletime_hours, numericality: true
  validates :number, presence: true, uniqueness: true
  validates :overtime_hours, numericality: true
  validates :performed_on, presence: true
  validates :straight_hours, numericality: true
  validates :travel_hours, numericality: true
  validates :user, presence: true
  validate :confirmation_must_belong_to_service_order_owner

  def confirmation_must_belong_to_service_order_owner
    if self.user != self.service_order.user
      self.errors.add(:user_id, "is not the owner of this service order")
    end
  end

  def total_hours
    (straight_hours + travel_hours + 1.5 * overtime_hours + 2 * doubletime_hours).round(3)
  end

  def raw_hours
    (straight_hours + travel_hours + overtime_hours + doubletime_hours).round(3)
  end
end
