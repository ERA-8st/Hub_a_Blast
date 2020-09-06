class CreateSongRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :song_ratings do |t|
      t.integer :user_id
      t.text :song_id
      t.float :rate
      t.timestamps
    end
  end
end
