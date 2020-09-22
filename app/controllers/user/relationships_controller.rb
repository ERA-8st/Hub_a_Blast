class User::RelationshipsController < ApplicationController

  before_action :set_user

  def create
		following = current_user.follow(@user)
		if params[:relationship][:index_user_id]
			@index_user = User.find(params[:relationship][:index_user_id])
			@follows = @index_user.relationships
		end
		if following.save
			flash[:success] = 'ユーザーをフォローしました'
		else
			flash.now[:alert] = 'ユーザーのフォローに失敗しました'
			redirect_back(fallback_location: root_path)
		end
  end

  def destroy
		following = current_user.unfollow(@user)
		if params[:relationship][:index_user_id]
			@index_user = User.find(params[:relationship][:index_user_id])
			@follows = @index_user.relationships
		end
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

end
