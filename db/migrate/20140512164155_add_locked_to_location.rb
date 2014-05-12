class AddLockedToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :locked, :boolean, default: true
  end
end
