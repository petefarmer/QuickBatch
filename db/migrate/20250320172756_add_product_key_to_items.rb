class AddProductKeyToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :product_key, null: true, foreign_key: true
  end
end
