class AlbumComment < ApplicationRecord
    validates :comment, :user_id, :album_id, presence: true

    belongs_to :user
end
