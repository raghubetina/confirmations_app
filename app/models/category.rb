class Category < ActiveRecord::Base
  attr_accessible :name

  # Associations
  has_many :service_orders

  # Validations
  validates :name, presence: true, uniqueness: true
end
