class User::AlbumRatingsController < ApplicationController

  before_action :correct_user, only: [:update]

  def create
    @album_rating = current_user.album_ratings.new(album_rating_params)
    @album_rating.album_id = params[:album_rating][:album_id]
    redirect_back(fallback_location: root_path) unless @album_rating.save
  end

  def update
    @album_rating = AlbumRating.find(params[:id])
    redirect_back(fallback_location: root_path) unless @album_rating.update(album_rating_params)
  end


  private

  def album_rating_params
    params.require(:album_rating).permit(:rate, :album_id)
  end

  def correct_user
    rating = AlbumRating.find(params[:id])
    redirect_to root_path unless current_user == rating.user
  end

end
