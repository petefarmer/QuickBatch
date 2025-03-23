class AddDimensionsToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :height, :integer
    add_column :items, :width, :integer
    add_column :items, :length, :integer
    add_column :items, :weight, :integer
  end
end
