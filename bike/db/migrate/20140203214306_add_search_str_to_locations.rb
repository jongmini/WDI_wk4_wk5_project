class AddSearchStrToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :search_str, :varchar
  end
end
