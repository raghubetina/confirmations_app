class CreateServiceOrders < ActiveRecord::Migration
  def change
    create_table :service_orders do |t|
      t.string :number
      t.text :description
      t.integer :category_id
      t.integer :user_id
      t.float :budget, default: 0
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
