class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :service_order_id
      t.date :performed_on
      t.float :travel_hours, default: 0
      t.float :straight_hours, default: 0
      t.float :overtime_hours, default: 0
      t.float :doubletime_hours, default: 0
      t.text :description
      t.string :number
      t.integer :user_id

      t.timestamps
    end
  end
end
