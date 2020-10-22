class SongImpression < ApplicationRecord

  validates :user_id, :song_id, presence: true

end
