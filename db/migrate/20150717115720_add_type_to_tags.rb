class AddTypeToTags < ActiveRecord::Migration
  def change
    add_column :tags, :type, :string, after: :slug
  end
end
