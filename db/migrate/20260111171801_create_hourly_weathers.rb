  class CreateHourlyWeathers < ActiveRecord::Migration[8.1]
    def change
      create_table :hourly_weathers do |t|
        t.datetime :timestamp
        t.float :latitude
        t.float :longitude
        t.float :temperature_2m
        t.float :wind_speed_10m

        t.timestamps
      end
      add_index :hourly_weathers, :timestamp, unique: true
    end
  end
