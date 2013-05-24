class ServiceOrder < ActiveRecord::Base
  attr_accessible :category_id, :description, :number, :user_id
end
