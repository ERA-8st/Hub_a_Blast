class ArtistComment < ApplicationRecord

  validates :comment, :user_id, :artist_id, presence: true

  belongs_to :user

end
