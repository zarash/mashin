class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
    add_index :locations, :name
  end
end