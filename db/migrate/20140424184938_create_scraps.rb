class CreateScraps < ActiveRecord::Migration
  def change
    create_table :scraps do |t|
      t.integer    :count
      t.string     :url
      t.string     :name

      t.timestamps
    end
  end
end
