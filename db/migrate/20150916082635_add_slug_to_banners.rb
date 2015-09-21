class AddSlugToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :slug, :string, unique: true, after: :title
  end
end
