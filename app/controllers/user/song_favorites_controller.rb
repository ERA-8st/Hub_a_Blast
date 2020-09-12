class User::SongFavoritesController < ApplicationController

	def create
		@song_favorite = current_user.song_favorites.new
		@song_favorite.song_id = params[:song_id]
		@song_favorite.save
		redirect_back(fallback_location: root_path)
	end

	def destroy
		song_favorite = SongFavorite.find(params[:id])
		song_favorite.destroy
		redirect_back(fallback_location: root_path)
	end
  
end
