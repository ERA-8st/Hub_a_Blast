class AddIndexToSongFavorite < ActiveRecord::Migration[5.2]

  def up
    change_column :song_favorites, :song_id, :text, null: false
    change_column :song_favorites, :user_id, :integer, null: false
  end

  def down
    hange_column :song_favorites, :song_id, :text
    change_column :song_favorites, :user_id, :integer
  end
  
  
  def change
    add_index  :song_favorites, [:user_id, :song_id], unique: true
  end
end
