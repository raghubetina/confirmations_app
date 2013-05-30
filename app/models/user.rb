class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :password, :password_confirmation

  has_secure_password

  # Associations
  has_many :confirmations
  has_many :service_orders
  has_many :shares, class_name: 'Share', foreign_key: 'shared_with_id'
  has_many :viewable, through: :shares, source: 'service_order'

  # Validations
  validates :email, presence: true, uniqueness: { :case_sensitive => false }
  validates :first_name, presence: true
  validates :last_name, presence: true

  # Callbacks
  before_save :downcase_email

  def downcase_email
    self.email = self.email.downcase
  end

  def full_name
    return "#{first_name} #{last_name}"
  end
end
