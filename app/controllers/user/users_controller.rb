class User::UsersController < ApplicationController

	require 'rspotify'
	RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

	def show
		@user = User.find(params[:id])
		# コメントを新しい順に並び替えて、同じ曲に対してのコメントを除外したデータを取得
		@song_comments = @user.song_comments.order("id DESC").select(:song_id).distinct
		# お気に入りを新しい順に並び替えて取得
		@song_favorites = @user.song_favorites.order("id DESC")
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
	

	private

	def user_params
    params.require(:user).permit(:user_name, :introduction, :profile_image)
  end
	

end
