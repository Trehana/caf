class AddDoNotDeleteFlagToPagesAndAds < ActiveRecord::Migration
  def change
    add_column :pages, :delete_protection, :integer, limit: 1, default: 0, after: :state
    add_column :ad_areas, :delete_protection, :integer, limit: 1, default: 0, after: :state
  end
end
