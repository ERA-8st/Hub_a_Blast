class CreateAlbumComments < ActiveRecord::Migration[5.2]
  def change
    create_table :album_comments do |t|
      t.text :comment
      t.integer :user_id
      t.text :album_id

      t.timestamps
    end
  end
end
