class ChangeDefaultValueUsageType < ActiveRecord::Migration
  def up
    change_column :ads, :usage_type, :integer, :default => 0
  end

  def down
    change_column :ads, :usage_type, :integer, :default => 10
  end
end
