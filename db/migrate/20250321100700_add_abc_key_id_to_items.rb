class AddAbcKeyIdToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :abc_key, foreign_key: { to_table: :admin_abc_keys }, null: true
  end
end
