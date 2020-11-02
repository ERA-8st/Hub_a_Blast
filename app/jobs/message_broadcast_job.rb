class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # @room = Room.find(message.room_id)
    user = User.find(message.user_id)
    @user_img = "#{user.profile_image.backend.directory}/#{user.profile_image_id}"
    @created_at = message.created_at.strftime("%Y-%m-%d %H:%M")
    ActionCable.server.broadcast 'room_channel' , message: message ,created_at: @created_at, user_img: @user_img
    # Do something later
  end

  private

  # def render_message(message)
  #   ApplicationController.renderer.render(partial: 'user/rooms/message', locals: { message: message })
  #   # ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  # end
  
end
