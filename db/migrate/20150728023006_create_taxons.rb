class CreateTaxons < ActiveRecord::Migration
  def change
    create_table :taxons do |t|
      t.integer :taxonomy_id
      t.integer :parent_id, null: true, index: true
      t.integer :postion
      t.string :permalink, uniq: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :taxonable_id
      t.string :taxonable_type

      t.timestamps null: true
    end
  end
end
