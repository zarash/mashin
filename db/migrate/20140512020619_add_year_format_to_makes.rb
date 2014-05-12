class AddYearFormatToMakes < ActiveRecord::Migration
  def change
    add_column :makes, :year_format, :boolean
  end
end
