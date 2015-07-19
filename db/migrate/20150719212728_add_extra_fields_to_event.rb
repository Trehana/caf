class AddExtraFieldsToEvent < ActiveRecord::Migration
  def change
    add_column :events, :facebook, :string, after: :description
    add_column :events, :twitter, :string, after: :description
    add_column :events, :instagram, :string, after: :description
    add_column :events, :pinterest, :string, after: :description
    add_column :events, :organizer, :string, after: :description
  end
end
