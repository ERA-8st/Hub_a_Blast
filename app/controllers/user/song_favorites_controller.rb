class User::SongFavoritesController < ApplicationController

	def index
		@user = User.find(params[:user_id])
		@song_favorites = @user.song_favorites
	end
	

	def create
		@song = RSpotify::Track.find(params[:song_id])
		new_song_favorite = current_user.song_favorites.new
		new_song_favorite.song_id = params[:song_id]
		new_song_favorite.save
		@song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
		# redirect_back(fallback_location: root_path)
	end

	def destroy
		@song = RSpotify::Track.find(params[:song_id])
		song_favorite = SongFavorite.find(params[:id])
		song_favorite.destroy
		# redirect_back(fallback_location: root_path)
	end
  
end
