class AddTitleToAdOtherFields < ActiveRecord::Migration
  def change
    add_column :ad_other_fields, :title, :string
  end
end
