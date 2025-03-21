class RemoveAbcKeyFromItems < ActiveRecord::Migration[8.0]
  def change
    remove_column :items, :abc_key, :string
  end
end
