class ChangeProfileShortBioColumLength < ActiveRecord::Migration
  def change
    change_column :profiles, :bio_short, :text
  end
end
