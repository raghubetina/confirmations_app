class CreateShares < ActiveRecord::Migration
  def change
    create_table :shares do |t|
      t.integer :service_order_id
      t.integer :shared_with_id

      t.timestamps
    end
  end
end
