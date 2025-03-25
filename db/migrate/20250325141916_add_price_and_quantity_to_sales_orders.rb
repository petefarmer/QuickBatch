class AddPriceAndQuantityToSalesOrders < ActiveRecord::Migration[7.1]
  def change
    add_column :sales_orders, :price, :decimal, precision: 10, scale: 2, null: false, default: 0.0
    add_column :sales_orders, :quantity, :integer, null: false, default: 0
  end
end
