class ChangeMenuColumnToStringInCafe < ActiveRecord::Migration
  def change
    change_column :cafes, :menu, :string
  end
end
