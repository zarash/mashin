class CreateSearches < ActiveRecord::Migration
  def change
    create_table :searches do |t|

      t.belongs_to :car_model
			t.belongs_to	:make 

			t.date  	:year_from 
			t.date		:year_to

			t.integer	:millage_from
			t.integer	:millage_to

			t.decimal	:price_from 
			t.decimal	:price_to

			t.string  :order

			t.boolean	:girbox

      t.boolean :image_has

			t.integer	:usage_type 

			t.boolean	:exchange

			t.boolean :damaged

			t.integer	:fuel 

      t.string  :location
      t.float   :latitude
      t.float   :longitude
			t.integer	:radius

      t.timestamps
    end
  end
end
