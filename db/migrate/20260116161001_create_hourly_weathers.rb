class CreateHourlyWeathers < ActiveRecord::Migration[8.1]
  def change
    create_table :hourly_weathers do |t|
      t.references :location, null: false, foreign_key: true
      t.datetime :timestamp
      t.decimal :temperature_2m
      t.decimal :wind_speed_10m

      t.timestamps
    end
    add_index :hourly_weathers, [ :location_id, :timestamp ], unique: true
  end
end
