class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :profile_image
  
  has_many :artist_comments, dependent: :destroy
  has_many :artist_ratings, dependent: :destroy
  has_many :album_comments, dependent: :destroy
  has_many :album_ratings, dependent: :destroy
  has_many :song_comments, dependent: :destroy
  has_many :song_ratings, dependent: :destroy
  has_many :song_favorites, dependent: :destroy

  has_many :relationships
  has_many :followings, through: :relationships, source: :follow
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
  has_many :followers, through: :reverse_of_relationships, source: :user

  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

  # フォローしようとしているUserが自分では無いか
  def follow(other_user)
    unless self == other_user
      self.relationships.find_or_create_by(follow_id: other_user.id)
    end
  end

  # フォローしている場合のみアンフォロー
  def unfollow(other_user)
    relationship = self.relationships.find_by(follow_id: other_user.id)
    relationship.destroy if relationship
  end

  # すでにフォローしていないか
  def following?(other_user)
    self.followings.include?(other_user)
  end

end
