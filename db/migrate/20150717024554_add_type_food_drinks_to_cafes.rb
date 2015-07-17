class AddTypeFoodDrinksToCafes < ActiveRecord::Migration
  def change
    add_column :cafes, :food, :string
    add_column :cafes, :type, :string
    add_column :cafes, :drinks, :string
  end
end
