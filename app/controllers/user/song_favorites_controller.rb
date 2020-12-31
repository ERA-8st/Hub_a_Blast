class User::SongFavoritesController < ApplicationController

  before_action :correct_user, only: [:destroy]

  def index
    @user = User.find(params[:user_id])
    @song_favorites = @user.song_favorites
    # DM
    room_present?(@user)
  end


  def create
    new_song_favorite = current_user.song_favorites.new
    new_song_favorite.song_id = params[:song_id]
    new_song_favorite.save
    @song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
  end

  def destroy
    song_favorite = SongFavorite.find(params[:id])
    song_favorite.destroy
  end

  private

  def correct_user
    song_favorite = SongFavorite.find(params[:id])
    redirect_to root_path unless current_user == song_favorite.user
  end

  def set_song
    @song = RSpotify::Track.find(params[:song_id])
  end

end
