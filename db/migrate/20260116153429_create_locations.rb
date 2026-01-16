class CreateLocations < ActiveRecord::Migration[8.1]
  def change
    create_table :locations do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :latitude, null: false
      t.decimal :longitude, null: false

      t.timestamps
    end
    add_index :locations, [ :user_id, :latitude, :longitude ], unique: true
  end
end
