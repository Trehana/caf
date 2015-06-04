class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :title
      t.string :designation
      t.string :bio_short
      t.text :bio
      t.string :state
      t.string :slug, unique: true

      t.timestamps null: false
    end
  end
end
