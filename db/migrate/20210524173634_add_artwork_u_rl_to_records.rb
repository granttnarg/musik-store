class AddArtworkURlToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :artwork_url, :string
  end
end
