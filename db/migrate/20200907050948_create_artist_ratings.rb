class CreateArtistRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :artist_ratings do |t|
      t.integer :user_id
      t.text :artist_id
      t.float :rate
      t.timestamps
    end
  end
end
