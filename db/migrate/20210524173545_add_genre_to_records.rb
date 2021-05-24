class AddGenreToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :genre, :string
  end
end
