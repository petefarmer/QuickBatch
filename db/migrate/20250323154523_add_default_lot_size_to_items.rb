class AddDefaultLotSizeToItems < ActiveRecord::Migration[7.1]
  def change
    add_column :items, :default_lot_size, :decimal, precision: 10, scale: 2, null: true
  end
end 