class CreateGallery < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :title
      t.string :state
      t.string :slug, unique: true
    end
  end
end
