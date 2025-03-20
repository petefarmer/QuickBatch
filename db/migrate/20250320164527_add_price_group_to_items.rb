class AddPriceGroupToItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :items, :price_group, null: true, foreign_key: true
  end
end
