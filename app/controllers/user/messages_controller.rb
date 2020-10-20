class User::MessagesController < ApplicationController
  
  before_action :authenticate_user!, only: [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.create(params.require(:message).permit(:user_id, :message, :room_id).merge(user_id: current_user.id))
      room = Room.find(params[:message][:room_id])
      @messages = room.messages
      pair_user = Entry.where(room_id: room.id).where.not(user_id: current_user.id)
      @pair_user = pair_user.first
      @pair_user.create_notification_message!(current_user, @message)
    else
      flash[:alert] = "メッセージ送信に失敗しました。"
    end
  end
  
end