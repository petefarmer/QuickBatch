class CreateEccnKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :eccn_keys do |t|
      t.string :name, null: false
      t.text :description

      t.timestamps
    end

    add_index :eccn_keys, :name, unique: true

    add_reference :items, :eccn_key, null: true, foreign_key: true
  end
end 