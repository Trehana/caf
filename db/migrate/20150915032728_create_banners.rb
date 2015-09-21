class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :line_1
      t.string :line_2
      t.string :line_3

      t.timestamps null: false
    end
  end
end
