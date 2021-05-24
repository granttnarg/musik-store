class AddFavouriteCountToArtists < ActiveRecord::Migration[6.1]
  def change
    add_column :artists, :favourite_count, :integer
  end
end
