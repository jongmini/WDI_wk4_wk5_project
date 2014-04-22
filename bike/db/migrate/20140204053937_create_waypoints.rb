class CreateWaypoints < ActiveRecord::Migration
  def change
    create_table :waypoints do |t|
      t.decimal :way_lat
      t.decimal :way_lng
      t.integer :journey_id

      t.timestamps
    end
  end
end
