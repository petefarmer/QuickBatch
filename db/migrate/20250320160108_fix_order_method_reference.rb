class FixOrderMethodReference < ActiveRecord::Migration[7.1]
  def change
    # First remove any existing reference that might be causing issues
    remove_reference :items, :order_method, if_exists: true
    
    # Then add the reference back properly
    add_reference :items, :order_method, foreign_key: true
  end
end
