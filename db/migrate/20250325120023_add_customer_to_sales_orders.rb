class AddCustomerToSalesOrders < ActiveRecord::Migration[7.1]
  def up
    # First add the column as nullable
    add_reference :sales_orders, :customer, null: true, foreign_key: true

    # Get or create a default customer
    default_customer = Customer.find_or_create_by!(customer_key: 'DEFAULT', customer_name: 'Default Customer')

    # Update all existing sales orders to use the default customer
    execute <<-SQL
      UPDATE sales_orders SET customer_id = #{default_customer.id} WHERE customer_id IS NULL
    SQL

    # Now make the column non-nullable
    change_column_null :sales_orders, :customer_id, false
  end

  def down
    remove_reference :sales_orders, :customer
  end
end
