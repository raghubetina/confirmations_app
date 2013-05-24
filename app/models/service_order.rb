class ServiceOrder < ActiveRecord::Base
  attr_accessible :category_id, :description, :number, :user_id, :user, :category

  # Associations
  belongs_to :category
  belongs_to :user
  has_many :confirmations

  # Validations
  validates :category, presence: true
  validates :number, presence: true
  validates :user, presence: true
end
