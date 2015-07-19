class AddStateToEmergingArtists < ActiveRecord::Migration
  def change
    add_column :emerging_artists, :state, :string, after: :body
  end
end
