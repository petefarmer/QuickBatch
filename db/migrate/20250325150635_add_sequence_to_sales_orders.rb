class AddSequenceToSalesOrders < ActiveRecord::Migration[7.1]
  def up
    # Create the sequence starting at 1000
    execute <<-SQL
      CREATE SEQUENCE sales_order_number_seq START WITH 1000;
    SQL

    # Update existing sales orders to use the sequence
    execute <<-SQL
      UPDATE sales_orders 
      SET sales_order_number = nextval('sales_order_number_seq')
      WHERE sales_order_number IS NULL;
    SQL

    # Alter the column to use the sequence
    execute <<-SQL
      ALTER TABLE sales_orders 
      ALTER COLUMN sales_order_number SET DEFAULT nextval('sales_order_number_seq');
    SQL
  end

  def down
    # Remove the sequence default
    execute <<-SQL
      ALTER TABLE sales_orders 
      ALTER COLUMN sales_order_number DROP DEFAULT;
    SQL

    # Drop the sequence
    execute <<-SQL
      DROP SEQUENCE sales_order_number_seq;
    SQL
  end
end
