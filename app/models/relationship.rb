class Relationship < ApplicationRecord

  validates :user_id, :follow_id, presence: true

  belongs_to :user
  belongs_to :follow, class_name: 'User'

end
