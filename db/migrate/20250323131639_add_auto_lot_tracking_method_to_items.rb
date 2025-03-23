class AddAutoLotTrackingMethodToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :auto_lot_tracking_method, null: true, foreign_key: true
  end
end
