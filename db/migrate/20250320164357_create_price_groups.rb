class CreatePriceGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :price_groups do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
