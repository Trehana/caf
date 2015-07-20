class AddSlugFieldToArtGalleryAndEmergingArtist < ActiveRecord::Migration
  def change
    add_column :art_galleries, :slug, :string, unique: true, after: :title
    add_column :emerging_artists, :slug, :string, unique: true, after: :title
  end
end
