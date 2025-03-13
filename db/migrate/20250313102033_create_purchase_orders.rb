class CreatePurchaseOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :purchase_orders do |t|
      t.string :purchase_order_number
      t.string :order_type

      t.timestamps
    end
  end
end
