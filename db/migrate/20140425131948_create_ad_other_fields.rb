class CreateAdOtherFields < ActiveRecord::Migration
  def change
    create_table :ad_other_fields do |t|
      t.belongs_to :ad, index: true
      t.string :tel
      t.string :source_url
      t.string :thumb_img

      t.timestamps
    end
    add_index :ad_other_fields, :source_url
  end
end
