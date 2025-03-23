class AddStorageConditionToItems < ActiveRecord::Migration[7.1]
  def change
    add_reference :items, :storage_condition, null: true, foreign_key: true
  end
end
