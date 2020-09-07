class User::ArtistRatingsController < ApplicationController

	def create
		@artist_rating = current_user.artist_ratings.new(artist_rating_params)
		@artist_rating.artist_id = params[:artist_rating][:artist_id]
		if @artist_rating.save
		else
			redirect_back(fallback_location: root_path)
		end
	end

	def update
		@artist_rating = ArtistRating.find(params[:id])
		if @artist_rating.update(artist_rating_params)
		else
			redirect_back(fallback_location: root_path)
		end
	end
	

	private

	def artist_rating_params
		params.require(:artist_rating).permit(:rate, :artist_id)
	end

end
