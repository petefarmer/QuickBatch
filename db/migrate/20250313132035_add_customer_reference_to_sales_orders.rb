class AddCustomerReferenceToSalesOrders < ActiveRecord::Migration[7.0]
  def change
    add_column :sales_orders, :customer_key, :string
    add_column :sales_orders, :customer_name, :string
    add_index :sales_orders, :customer_key
    add_index :sales_orders, :customer_name
  end
end
