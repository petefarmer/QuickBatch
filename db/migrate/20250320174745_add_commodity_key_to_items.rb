class AddCommodityKeyToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :commodity_key, null: true, foreign_key: true
  end
end
