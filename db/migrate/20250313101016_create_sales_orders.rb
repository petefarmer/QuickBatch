class CreateSalesOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :sales_orders do |t|
      t.string :sales_order_number
      t.string :order_type

      t.timestamps
    end
  end
end
