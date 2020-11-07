class SongFavorite < ApplicationRecord

  belongs_to :user

  validates :song_id, uniqueness: { scope: :user_id  }
  validates :song_id, :user_id, presence: true

end
