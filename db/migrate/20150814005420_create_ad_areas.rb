class CreateAdAreas < ActiveRecord::Migration
  def change
    create_table :ad_areas do |t|
      t.string :title
      t.text :ad_text
      t.string :css_class
      t.string :state
      t.string :slug

      t.timestamps null: false
    end
  end
end
