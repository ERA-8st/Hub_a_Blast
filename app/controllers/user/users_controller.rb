class User::UsersController < ApplicationController

	require 'rspotify'
	RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

	def show
		@user = User.find(params[:id])
		@song_comments = @user.song_comments.order("id DESC").select(:song_id).distinct.limit(3)
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

	private

	def user_params
    params.require(:user).permit(:user_name, :introduction, :profile_image)
  end
	

end
