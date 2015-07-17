class ChangeAddressFields < ActiveRecord::Migration
  def change
    add_column :addresses, :suburb, :string, after: :address
    add_column :addresses, :city, :string, after: :suburb
  end
end
