class CreateSongComments < ActiveRecord::Migration[5.2]
  def change
    create_table :song_comments do |t|
      t.text :comment
      t.integer :user_id
      t.text :song_id

      t.timestamps
    end
  end
end
