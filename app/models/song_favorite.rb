class SongFavorite < ApplicationRecord

  belongs_to :user

  validates :song_id,  uniqueness: { scope: :user_id  }

end
