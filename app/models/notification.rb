class Notification < ApplicationRecord

  default_scope->{order(created_at: :desc)}

  validates :visited_id, :visiter_id, :action, presence: true
  
  validates :message, :room_id, presence: true, if: :include?

  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  private

  def include?
    action == "message"
  end
  
end