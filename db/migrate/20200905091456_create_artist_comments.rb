class CreateArtistComments < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_comments do |t|
      t.text :comment
      t.integer :user_id
      t.text :artist_id

      t.timestamps
    end
  end
end
