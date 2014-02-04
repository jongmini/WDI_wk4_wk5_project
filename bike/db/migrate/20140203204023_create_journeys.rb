class CreateJourneys < ActiveRecord::Migration
  def change
    create_table :journeys do |t|
      t.string :name
      t.string :origin
      t.decimal :orig_lat
      t.decimal :orig_lng
      t.string :destination
      t.decimal :dest_lat
      t.decimal :dest_lng
      t.string :user_id

      t.timestamps
    end
  end
end
