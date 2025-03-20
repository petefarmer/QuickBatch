class MakeItemSubtypeAndOrderMethodNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :item_subtype_id, true
    change_column_null :items, :order_method_id, true
  end
end
