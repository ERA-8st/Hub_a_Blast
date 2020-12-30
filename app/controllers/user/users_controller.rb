class User::UsersController < ApplicationController

  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    
    binding.pry
    
    # コメントを新しい順に並び替えて、同じ曲に対してのコメントを除外したデータを取得
    @song_comments = @user.song_comments.order("id DESC").select(:song_id).distinct.limit(5)
    # お気に入りを新しい順に並び替えて取得
    @song_favorites = @user.song_favorites.order("id DESC").limit(5)
    # DM
    room_present?(@user)
    if @user == current_user
      # ユーザーのメッセージを新しい順に並び替えて同一のroomに対してのメッセージを除外
      @messages = @user.messages.order("id DESC").select(:room_id).distinct.limit(3)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_user_path(@user), notice: "You have updated user successfully."
    else
      render "user/users/edit"
    end
  end

  def follow_index
    @index_user = User.find(params[:id])
    @follows = @index_user.relationships
  end

  def follower_index
    @followers = Relationship.where(follow_id: params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :introduction, :profile_image)
  end

  def correct_user
    user = User.find(params[:id])
    unless current_user == user
      redirect_to root_path
    end
  end

end
