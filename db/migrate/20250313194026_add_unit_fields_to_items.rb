class AddUnitFieldsToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :stock_unit, :string, default: 'kg'
    add_column :items, :purchase_unit, :string, default: 'kg'
    add_column :items, :sales_unit, :string, default: 'kg'
    add_column :items, :production_unit, :string, default: 'kg'
  end
end
