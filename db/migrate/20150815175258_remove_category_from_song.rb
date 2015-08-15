class RemoveCategoryFromSong < ActiveRecord::Migration
  def change
    remove_column :songs, :category_id, :integer
  end
end
