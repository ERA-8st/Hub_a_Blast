class AlbumRating < ApplicationRecord

  belongs_to :user
  validates :user_id, :album_id, :rate, presence: true
  validates :rate ,:numericality => { :less_than_or_equal_to => 5 }
end
