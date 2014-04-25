class CreateCarModels < ActiveRecord::Migration
  def change
    create_table :car_models do |t|
      t.string :name, index: true
      t.belongs_to :make, index: true

      t.timestamps
    end

    add_index :car_models, [:name]
  end
end
