class CreateAdminAbcKeys < ActiveRecord::Migration[7.0]
  def change
    create_table :admin_abc_keys do |t|
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end

    add_index :admin_abc_keys, :name, unique: true
  end
end
