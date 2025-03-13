class ChangeItemSubtypeToItemSubtypeId < ActiveRecord::Migration[8.0]
  def up
    # First, create a temporary column to store the item_subtype_id
    add_column :items, :item_subtype_id, :integer

    # Update the item_subtype_id based on the existing item_subtype string
    execute <<-SQL
      UPDATE items i
      SET item_subtype_id = ist.id
      FROM item_subtypes ist
      WHERE i.item_subtype = ist.name
    SQL

    # Remove the old item_subtype column
    remove_column :items, :item_subtype

    # Add foreign key constraint
    add_foreign_key :items, :item_subtypes
  end

  def down
    # Remove foreign key constraint
    remove_foreign_key :items, :item_subtypes

    # Add back the item_subtype column
    add_column :items, :item_subtype, :string

    # Restore the item_subtype string from the item_subtypes table
    execute <<-SQL
      UPDATE items i
      SET item_subtype = ist.name
      FROM item_subtypes ist
      WHERE i.item_subtype_id = ist.id
    SQL

    # Remove the item_subtype_id column
    remove_column :items, :item_subtype_id
  end
end
