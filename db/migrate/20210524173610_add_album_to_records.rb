class AddAlbumToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :album, :string
  end
end
