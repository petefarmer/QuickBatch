class AddManufacturerCodeToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :manufacturer_code, :string
  end
end
