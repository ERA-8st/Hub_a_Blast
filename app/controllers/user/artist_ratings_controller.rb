class User::ArtistRatingsController < ApplicationController

  before_action :correct_user, only: [:update]

  def create
    @artist_rating = current_user.artist_ratings.new(artist_rating_params)
    @artist_rating.artist_id = params[:artist_rating][:artist_id]
    redirect_back(fallback_location: root_path) unless @artist_rating.save
  end

  def update
    @artist_rating = ArtistRating.find(params[:id])
    redirect_back(fallback_location: root_path) unless @artist_rating.update(artist_rating_params)
  end


  private

  def artist_rating_params
    params.require(:artist_rating).permit(:rate, :artist_id)
  end

  def correct_user
    rating = ArtistRating.find(params[:id])
    redirect_to root_path unless current_user == rating.user
  end

end
