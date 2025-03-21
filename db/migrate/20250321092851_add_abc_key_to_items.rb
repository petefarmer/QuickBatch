class AddAbcKeyToItems < ActiveRecord::Migration[8.0]
  def change
    add_column :items, :abc_key, :string
  end
end
