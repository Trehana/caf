class AddBusinessHoursToCafe < ActiveRecord::Migration
  def change
    add_column :cafes, :business_hours, :text
  end
end
