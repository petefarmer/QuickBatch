class MoveAbcKeysFromAdminToItems < ActiveRecord::Migration[7.0]
  def up
    # Create new table
    create_table :abc_keys do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end

    # Copy data
    execute <<-SQL
      INSERT INTO abc_keys (name, description, created_at, updated_at)
      SELECT name, description, created_at, updated_at
      FROM admin_abc_keys
    SQL

    # Update foreign keys
    execute <<-SQL
      UPDATE items
      SET abc_key_id = (
        SELECT id FROM abc_keys
        WHERE abc_keys.name = admin_abc_keys.name
      )
      FROM admin_abc_keys
      WHERE items.abc_key_id = admin_abc_keys.id
    SQL

    # Remove foreign key constraint
    remove_foreign_key :items, :admin_abc_keys

    # Drop old table
    drop_table :admin_abc_keys
  end

  def down
    # Create old table
    create_table :admin_abc_keys do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.timestamps
    end

    # Copy data back
    execute <<-SQL
      INSERT INTO admin_abc_keys (name, description, created_at, updated_at)
      SELECT name, description, created_at, updated_at
      FROM abc_keys
    SQL

    # Update foreign keys back
    execute <<-SQL
      UPDATE items
      SET abc_key_id = (
        SELECT id FROM admin_abc_keys
        WHERE admin_abc_keys.name = abc_keys.name
      )
      FROM abc_keys
      WHERE items.abc_key_id = abc_keys.id
    SQL

    # Add foreign key constraint back
    add_foreign_key :items, :admin_abc_keys

    # Drop new table
    drop_table :abc_keys
  end
end
