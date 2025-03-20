class RemoveCustomerKeyAndNameFromSalesOrders < ActiveRecord::Migration[8.0]
  def change
    remove_index :sales_orders, :customer_key if index_exists?(:sales_orders, :customer_key)
    remove_index :sales_orders, :customer_name if index_exists?(:sales_orders, :customer_name)
    remove_column :sales_orders, :customer_key, :string if column_exists?(:sales_orders, :customer_key)
    remove_column :sales_orders, :customer_name, :string if column_exists?(:sales_orders, :customer_name)
  end
end
