class AddAutoLotTrackingMethodToTrackSerialLots < ActiveRecord::Migration[8.0]
  def change
    create_table :auto_lot_tracking_methods do |t|
      t.string :name
      t.text :description
      t.timestamps
    end

    add_reference :track_serial_lots, :auto_lot_tracking_method, null: true, foreign_key: true
  end
end
