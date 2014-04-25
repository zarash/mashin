class CreateImageUrls < ActiveRecord::Migration
  def change
    create_table :image_urls do |t|
      t.belongs_to :ad, index: true
      t.string :url

      t.timestamps
    end
  end
end
