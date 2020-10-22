class CreateSongImpressions < ActiveRecord::Migration[5.2]
  def change
    create_table :song_impressions do |t|
      t.integer :user_id
      t.text :song_id
      t.timestamps
    end
  end
end
