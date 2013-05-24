class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :service_order_id
      t.date :performed_on
      t.integer :travel_hours, default: 0
      t.integer :straight_hours, default: 0
      t.integer :overtime_hours, default: 0
      t.integer :doubletime_hours, default: 0
      t.text :description
      t.text :number
      t.integer :user_id

      t.timestamps
    end
  end
end
