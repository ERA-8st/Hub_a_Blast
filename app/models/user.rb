class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :song_comments, dependent: :destroy
  has_many :artist_comments, dependent: :destroy
  has_many :album_comments, dependent: :destroy

end