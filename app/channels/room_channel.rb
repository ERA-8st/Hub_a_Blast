class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from "room_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    @pair_user_id = Entry.where(room_id: data['room_id']).where.not(user_id: data['user_id']).first.user_id
    Notification.create! visiter_id: data['user_id'], visited_id: @pair_user_id, action: "message", message: data['message'], room_id: data['room_id']
    Message.create! message: data['message'], user_id: data['user_id'], room_id: data['room_id']
  end

end
