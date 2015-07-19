class CreateAwards < ActiveRecord::Migration
  def change
    create_table :awards do |t|
      t.string :name
      t.string :year
      t.string :awardable_id
      t.string :awardable_type
      t.timestamps null: false
    end
  end
end
