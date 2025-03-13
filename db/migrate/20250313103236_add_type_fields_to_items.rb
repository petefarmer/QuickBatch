class AddTypeFieldsToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :item_type, :string
    add_column :items, :item_subtype, :string
  end
end
