class CreateArtGalleries < ActiveRecord::Migration
  def change
    create_table :art_galleries do |t|
      t.string :title
      t.text :body
      t.string :business_hours
      t.string :state

      t.timestamps null: false
    end
  end
end
