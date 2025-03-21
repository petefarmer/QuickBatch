class AddPurchaseableAndSaleableToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :purchaseable, :boolean, default: false, null: false
    add_column :items, :saleable, :boolean, default: false, null: false
  end
end
