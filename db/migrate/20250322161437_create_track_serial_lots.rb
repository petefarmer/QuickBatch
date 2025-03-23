class CreateTrackSerialLots < ActiveRecord::Migration[8.0]
  def change
    create_table :track_serial_lots do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
