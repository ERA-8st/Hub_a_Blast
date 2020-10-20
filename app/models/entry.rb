class Entry < ApplicationRecord

  belongs_to :user
  belongs_to :room

  def create_notification_message!(current_user, message)
    notification = current_user.active_notifications.new(
      visited_id: user_id,
      message: message.message,
      action: 'message',
      room_id: message.room_id
    )
    notification.save if notification.valid?
  end

end
