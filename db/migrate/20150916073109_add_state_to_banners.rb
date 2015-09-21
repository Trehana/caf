class AddStateToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :state, :string, default: "published"
  end
end
