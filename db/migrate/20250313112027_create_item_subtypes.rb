class CreateItemSubtypes < ActiveRecord::Migration[8.0]
  def change
    create_table :item_subtypes do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
