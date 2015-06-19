class CreateCafes < ActiveRecord::Migration
  def change
    create_table :cafes do |t|
      t.string :title
      t.string :slug, unique: true
      t.text :body
      t.text :menu
      t.integer :cover_photo_repeat, limit: 1, default: 0
      t.string :state
      t.timestamps null: false
    end
  end
end
