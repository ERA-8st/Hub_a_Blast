class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    # @room = Room.find(message.room_id)
    # @messages = @room.messages
    # ActionCable.server.broadcast "room_channel" , message: @messages
    ActionCable.server.broadcast 'room_channel' , message: message
    # Do something later
  end

  private

  # def render_message(message)
  #   ApplicationController.renderer.render(partial: 'user/rooms/message', locals: { message: message })
  #   # ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  # end
  
end
