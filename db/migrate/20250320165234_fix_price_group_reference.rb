class FixPriceGroupReference < ActiveRecord::Migration[7.1]
  def up
    # First remove any existing price_group_id column if it exists
    remove_column :items, :price_group_id if column_exists?(:items, :price_group_id)
    
    # Then add it back as nullable
    add_reference :items, :price_group, null: true, foreign_key: true
  end

  def down
    remove_reference :items, :price_group
  end
end
