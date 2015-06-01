class AddCoverPhotoRepeatToPages < ActiveRecord::Migration
  def change
    add_column :pages, :cover_photo_repeat, :tinyint, limit: 1, default: 0
  end
end
