class CreateSongFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :song_favorites do |t|
      t.text :song_id
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
