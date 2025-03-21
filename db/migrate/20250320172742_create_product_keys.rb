class CreateProductKeys < ActiveRecord::Migration[8.0]
  def change
    create_table :product_keys do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
