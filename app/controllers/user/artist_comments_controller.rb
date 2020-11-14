class User::ArtistCommentsController < ApplicationController

  before_action :correct_user, only: [:update, :destroy]
  before_action :login_user_present?

  def create
    @artist_comment = current_user.artist_comments.new(artist_comment_params)
    @artist_comment.artist_id = params[:artist_comment][:artist_id]
    @page = params[:page]
    if @artist_comment.save 
      redirect_to user_spotify_artist_show_path(@artist_comment.artist_id, page: @page)
    else
      @artist = RSpotify::Artist.find(params[:artist_comment][:artist_id])
      @albums = @artist.albums
      @artist_comments = ArtistComment.where(artist_id: @artist.id).order("id DESC").page(params[:page]).per(5)
      @error = true
      render "user/spotify/artist_show"
    end
  end

  def update
    @comment = ArtistComment.find(params[:id])
    @page = params[:page]
      if @comment.update(artist_comment_params)
        redirect_to user_spotify_artist_show_path(@comment.artist_id, page: @page)
      else
        @artist = RSpotify::Artist.find(@comment.artist_id)
        @albums = @artist.albums
        @artist_comment = ArtistComment.new
        @artist_comments = ArtistComment.where(artist_id: @artist.id).order("id DESC").page(params[:page]).per(5)
        @error = true
        render "user/spotify/artist_show"
      end
  end
  
  def destroy
    comment = ArtistComment.find(params[:id])
    comment.destroy
    redirect_to user_spotify_artist_show_path(comment.artist_id)
  end

  private

  def artist_comment_params
    params.require(:artist_comment).permit(:comment)
  end

  def correct_user
    comment = ArtistComment.find(params[:id])
    unless current_user == comment.user
      redirect_to root_path
    end
  end

end
