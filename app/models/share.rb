class Share < ActiveRecord::Base
  attr_accessible :service_order_id, :shared_with_id, :service_order, :shared_with

  # Associations
  belongs_to :service_order
  belongs_to :shared_with, class_name: 'User'

  # Validations
  validates :service_order, presence: true
  validates :shared_with, presence: true
  validates :service_order_id, uniqueness: { scope: :shared_with_id, message: 'already shared with that user' }
  validate :cannot_share_with_yourself

  def cannot_share_with_yourself
    if self.service_order.user == self.shared_with
      self.errors.add(:service_order_id, 'cannot be shared with its owner')
    end
  end
end
