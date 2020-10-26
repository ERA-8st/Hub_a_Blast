class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    ActionCable.server.broadcast 'room_channel', message: data['message'], user_id: data['user_id'], room_id: data['room_id']
    # Message.create! message: data['message'], user_id: data['user_id'], room_id: data['room_id']
  end

end
