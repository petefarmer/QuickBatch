class AddTrackSerialLotToItems < ActiveRecord::Migration[7.0]
  def change
    add_reference :items, :track_serial_lot, null: true, foreign_key: true
  end
end
