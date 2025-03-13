class ChangeItemTypeToItemTypeId < ActiveRecord::Migration[8.0]
  def up
    # First, create a temporary column to store the item_type_id
    add_column :items, :item_type_id, :integer

    # Update the item_type_id based on the existing item_type string
    execute <<-SQL
      UPDATE items i
      SET item_type_id = it.id
      FROM item_types it
      WHERE i.item_type = it.name
    SQL

    # Remove the old item_type column
    remove_column :items, :item_type

    # Add foreign key constraint
    add_foreign_key :items, :item_types
  end

  def down
    # Remove foreign key constraint
    remove_foreign_key :items, :item_types

    # Add back the item_type column
    add_column :items, :item_type, :string

    # Restore the item_type string from the item_types table
    execute <<-SQL
      UPDATE items i
      SET item_type = it.name
      FROM item_types it
      WHERE i.item_type_id = it.id
    SQL

    # Remove the item_type_id column
    remove_column :items, :item_type_id
  end
end
