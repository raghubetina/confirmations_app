class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password_digest

  # Associations
  has_many :confirmations
  has_many :service_orders

  # Validations
  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true
end
