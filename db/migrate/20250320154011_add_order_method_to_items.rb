class AddOrderMethodToItems < ActiveRecord::Migration[8.0]
  def change
    add_reference :items, :order_method, foreign_key: true
  end
end
