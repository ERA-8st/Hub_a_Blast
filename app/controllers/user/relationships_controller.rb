class User::RelationshipsController < ApplicationController

  prepend_before_action :authenticate_user!
  before_action :set_user, :set_follows

  def create
    following = current_user.follow(@user)
    if following.save
      flash[:success] = 'ユーザーをフォローしました'
      @user.create_notification_follow!(current_user)
    else
      flash.now[:alert] = 'ユーザーのフォローに失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    following = current_user.unfollow(@user)
    if following.destroy
      flash[:success] = 'ユーザーのフォローを解除しました'
    else
      flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
      redirect_back(fallback_location: root_path)
    end
  end

  private
  
  def set_user
    @user = User.find(params[:relationship][:follow_id])
  end

  def set_follows
    if params[:relationship][:index_user_id]
      @follows = User.find(params[:relationship][:index_user_id]).relationships
    end
  end

end
