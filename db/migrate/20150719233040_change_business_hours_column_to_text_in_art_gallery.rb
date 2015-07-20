class ChangeBusinessHoursColumnToTextInArtGallery < ActiveRecord::Migration
  def change
    change_column :art_galleries, :business_hours, :text
  end
end
