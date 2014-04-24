class CreateAds < ActiveRecord::Migration
  def change
    create_table :ads do |t|
      t.belongs_to :user, index: true
      t.belongs_to :carmodel, index: true
      t.belongs_to :body_color, index: true
      t.belongs_to :internal_color, index: true

      t.date :year
      t.integer :price
      t.integer :millage
      t.integer :fuel
      t.integer :usage_type, default: 10 # karkarde =0, sefr: 1, havale: 2
      t.boolean :girbox, default: false
      t.date :expration
      t.boolean :active, default: false
      t.text :details
      t.string :origin_url, index:true
      
      t.string :ad_tel

      t.timestamps
    end
  end
end