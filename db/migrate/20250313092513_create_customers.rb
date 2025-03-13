class CreateCustomers < ActiveRecord::Migration[8.0]
  def change
    create_table :customers do |t|
      t.string :customer_key
      t.string :customer_name

      t.timestamps
    end
  end
end
