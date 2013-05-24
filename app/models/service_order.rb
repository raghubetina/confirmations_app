class ServiceOrder < ActiveRecord::Base
  attr_accessible :category_id, :description, :number, :user_id, :user, :category, :budget, :completed

  # Associations
  belongs_to :category
  belongs_to :user
  has_many :confirmations

  # Validations
  validates :category, presence: true
  validates :number, presence: true
  validates :user, presence: true

  def straight_hours
    self.confirmations.sum(:straight_hours)
  end

  def travel_hours
    self.confirmations.sum(:travel_hours)
  end

  def overtime_hours
    self.confirmations.sum(:overtime_hours)
  end

  def doubletime_hours
    self.confirmations.sum(:doubletime_hours)
  end

  def total_hours
    straight_hours + travel_hours + 1.5 * overtime_hours + 2 * doubletime_hours
  end

  def remaining_hours
    self.budget - self.total_hours
  end
end
