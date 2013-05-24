class CreateConfirmations < ActiveRecord::Migration
  def change
    create_table :confirmations do |t|
      t.integer :service_order_id
      t.date :performed_on
      t.integer :travel_hours
      t.integer :straight_hours
      t.integer :overtime_hours
      t.integer :doubletime_hours
      t.text :description
      t.text :number
      t.integer :user_id

      t.timestamps
    end
  end
end
