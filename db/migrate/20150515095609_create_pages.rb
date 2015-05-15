class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body
      t.string :meta_tags

      t.timestamps null: false
    end
  end
end
