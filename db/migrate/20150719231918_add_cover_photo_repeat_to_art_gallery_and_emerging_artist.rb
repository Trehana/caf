class AddCoverPhotoRepeatToArtGalleryAndEmergingArtist < ActiveRecord::Migration
  def change
    add_column :art_galleries, :cover_photo_repeat, :integer, limit: 1, default: 0, after: :body
    add_column :emerging_artists, :cover_photo_repeat, :integer, limit: 1, default: 0, after: :body
  end
end
