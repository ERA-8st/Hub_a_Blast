class User::SongRatingsController < ApplicationController

	def create
		@song_rating = current_user.song_ratings.new(song_rating_params)
		@song_rating.song_id = params[:song_rating][:song_id]
		if @song_rating.save

		else
			redirect_back(fallback_location: root_path)
		end
	end

	def update
		@song_rating = SongRating.find(params[:id])
		if @song_rating.update(song_rating_params)
		else
			redirect_back(fallback_location: root_path)
		end
	end
	

	private

	def song_rating_params
		params.require(:song_rating).permit(:rate, :song_id)
	end

end
