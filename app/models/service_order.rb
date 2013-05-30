class ServiceOrder < ActiveRecord::Base
  attr_accessible :category_id, :description, :number, :user_id, :user, :category, :budget, :completed

  # Associations
  belongs_to :category
  belongs_to :user
  has_many :confirmations
  has_many :shares
  has_many :viewers, through: :shares, source: :shared_with

  # Validations
  validates :category, presence: true
  validates :number, presence: true, uniqueness: true
  validates :user, presence: true

  # Callbacks
  before_save :budget_should_be_zero_for_callouts

  def budget_should_be_zero_for_callouts
    if self.category.name == "Callout"
      self.budget = 0
    end
  end

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
    (straight_hours + travel_hours + 1.5 * overtime_hours + 2 * doubletime_hours).round(3)
  end

  def remaining_hours
    self.budget - self.total_hours
  end
end
