class AddEmailToEventAndRemoveLocation < ActiveRecord::Migration
  def change
    add_column :events, :email, :string, after: :admission
    remove_column :events, :location, :string, after: :admission
  end
end
