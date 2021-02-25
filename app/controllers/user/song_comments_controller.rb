class User::SongCommentsController < ApplicationController

  before_action :login_user_present?
  before_action :correct_comment_user, only: [:update, :destroy]
  before_action :set_page, except: [:destroy]

  def create
    @song_comment = current_user.song_comments.new(song_comment_params)
    @song_comment.song_id = params[:song_comment][:song_id]
    if @song_comment.save 
      redirect_to user_spotify_song_show_path(@song_comment.song_id, page: @page)
    else
      set_error_variables(@song_comment.song_id, params[:page])
    end

  end

  def update
    if @comment.update(song_comment_params)
      redirect_to user_spotify_song_show_path(@comment.song_id, page: @page)
    else
      @song_comment = SongComment.new
      set_error_variables(@comment.song_id, params[:page])
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to user_spotify_song_show_path(@comment.song_id)
  end

  def set_error_variables(song_id, page_params)
    @song = RSpotify::Track.find(song_id)
    @album = @song.album
    @song_comments = SongComment.where(song_id: @song.id).order("id DESC").page(page_params).per(5)
    if user_signed_in?
      @song_rating = current_user.song_ratings.find_by(song_id: @song.id)
      @new_song_rating = current_user.song_ratings.new
    end
    @song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
    @error = true
    render "user/spotify/song_show"
  end

  private

  def song_comment_params
    params.require(:song_comment).permit(:comment)
  end

end
