class User::RoomsController < ApplicationController

  before_action :authenticate_user!

  def create
    @room = Room.create
    @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
    @entry2 = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    redirect_to user_room_path(@room.id, pair_user_id: @entry2.user_id)
  end

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id,room_id: @room.id).present?
      @messages = @room.messages.includes(:user)
      @pair_user = User.find(params[:pair_user_id])
      # フッター固定用
      @fixed_footer = true
    else
      redirect_back(fallback_location: root_path)
    end
  end
end
