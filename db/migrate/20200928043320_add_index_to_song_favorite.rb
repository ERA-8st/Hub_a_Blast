class AddIndexToSongFavorite < ActiveRecord::Migration[5.2]
  
  def change
    change_column_null :song_favorites, :song_id,  false
    change_column_null :song_favorites, :user_id,  false
    add_index  :song_favorites, [:user_id, :song_id], unique: true
  end
end
