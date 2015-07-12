class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.string :slug, unique: true
      t.date :starts_at
      t.date :ends_at
      t.time :opens_at
      t.time :closes_at
      t.string :admission
      t.string :location
      t.text :description
      t.integer :cover_photo_repeat, limit: 1, default: 0
      t.string :state

      t.timestamps null: false
    end
  end
end
