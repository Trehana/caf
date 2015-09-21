class AddTitleToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :title, :string, default: "Headline Banner"
  end
end
