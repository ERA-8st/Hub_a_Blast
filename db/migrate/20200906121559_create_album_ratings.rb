class CreateAlbumRatings < ActiveRecord::Migration[5.2]
  def change
    create_table :album_ratings do |t|
      t.integer :user_id
      t.text :album_id
      t.float :rate
      t.timestamps
    end
  end
end
