class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :country_code, limit: 2
      t.string :postal_code, limit: 10
      t.integer :addressable_id
      t.string :addressable_type

      t.timestamps null: false
    end
  end
end
