class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable, :omniauthable

  attachment :profile_image

  validates :user_name, presence: true, length: { maximum: 10 } 
  attachment :profile_image, content_type: ["image/jpeg", "image/png", "image/gif"]
  
  
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

  has_many :active_notifications, class_name: "Notification", foreign_key: "visiter_id", dependent: :destroy
  has_many :passive_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

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

  # Twitterログイン
  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first
    unless user
      user = User.create(
        provider: auth.provider,
        uid:      auth.uid,
        user_name: auth.info.nickname,
        email:    User.dummy_email(auth),
        remote_profile_image_url: auth.info.image,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and action = ? ",current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end
  

  private

  def self.dummy_email(auth)
    "#{auth.uid}-#{auth.provider}@example.com"
  end

end
