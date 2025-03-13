class CreateItems < ActiveRecord::Migration[8.0]
  def change
    create_table :items do |t|
      t.string :item_key
      t.string :upc_key
      t.text :description

      t.timestamps
    end
  end
end
