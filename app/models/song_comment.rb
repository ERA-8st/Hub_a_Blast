class SongComment < ApplicationRecord

  validates :comment, :user_id, :song_id, presence: true

  belongs_to :user

end
