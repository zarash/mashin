class CreateMakes < ActiveRecord::Migration
  def change
    create_table :makes do |t|
      t.string :name, index: true

      t.timestamps
    end
    add_index :makes, [:name]
    
  end
end
