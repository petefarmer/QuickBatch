class ChangeItemSubtypeIdToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :item_subtype_id, true
  end
end
