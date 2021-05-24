class AddLikeCountToRecords < ActiveRecord::Migration[6.1]
  def change
    add_column :records, :like_count, :integer
  end
end
