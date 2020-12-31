class User::SongRatingsController < ApplicationController

  before_action :correct_user, only: [:update]

  def create
    @song_rating = current_user.song_ratings.new(song_rating_params)
    @song_rating.song_id = params[:song_rating][:song_id]
    redirect_back(fallback_location: root_path) unless @song_rating.save
  end

  def update
    @song_rating = SongRating.find(params[:id])
    redirect_back(fallback_location: root_path) unless @song_rating.update(song_rating_params)
  end

  private

  def song_rating_params
    params.require(:song_rating).permit(:rate, :song_id)
  end

  def correct_user
    rating = SongRating.find(params[:id])
    redirect_to root_path unless current_user == rating.user
  end

end
