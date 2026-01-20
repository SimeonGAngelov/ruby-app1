class RemoveUniqueIndexOnHourlyWeathersTimestamp < ActiveRecord::Migration[8.1]
  def change
    remove_index :hourly_weathers, name: "index_hourly_weathers_on_timestamp"
  end
end
