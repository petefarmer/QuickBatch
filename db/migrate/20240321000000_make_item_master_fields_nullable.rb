class MakeItemMasterFieldsNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :items, :item_type_id, true
    change_column_null :items, :item_subtype_id, true
    change_column_null :items, :order_method_id, true
    change_column_null :items, :price_group_id, true
    change_column_null :items, :product_key_id, true
    change_column_null :items, :commodity_key_id, true
    change_column_null :items, :abc_key_id, true
  end
end 