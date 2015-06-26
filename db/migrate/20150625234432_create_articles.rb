class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.string :slug, unique: true
      t.integer :cover_photo_repeat, limit: 1, default: 0
      t.string :state

      t.timestamps null: false
    end
  end
end
