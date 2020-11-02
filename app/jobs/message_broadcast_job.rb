class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    user = User.find(message.user_id)
    @user_img = "#{user.profile_image.backend.directory}/#{user.profile_image_id}"
    @created_at = message.created_at.strftime("%Y-%m-%d %H:%M")
    ActionCable.server.broadcast 'room_channel' , message: message ,created_at: @created_at, user_img: @user_img
  end

end
