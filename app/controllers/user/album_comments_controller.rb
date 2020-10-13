class User::AlbumCommentsController < ApplicationController

  before_action :correct_user, only: [:update, :destroy]

  def create
    @album_comment = current_user.album_comments.new(album_comment_params)
    @album_comment.album_id = params[:album_comment][:album_id]
    @page = params[:page]
    if @album_comment.save 
      redirect_to user_spotify_album_show_path(@album_comment.album_id, page: @page)
    else
      @album = RSpotify::Album.find(@album_comment.album_id)
      @songs = @album.tracks
      @album_comments = AlbumComment.where(album_id: @album.id).order("id DESC").page(params[:page]).per(5)
      if user_signed_in?
        @album_rating = current_user.album_ratings.find_by(album_id: @album.id)
        @new_album_rating = current_user.album_ratings.new
      end
      @error = true
      render "user/spotify/album_show"
    end
  end

  def update
    @comment = AlbumComment.find(params[:id])
    @page = params[:page]
    if @comment.update(album_comment_params)
      redirect_to user_spotify_album_show_path(@comment.album_id, page: @page)
    else
      @album = RSpotify::Album.find(@comment.album_id)
      @songs = @album.tracks
      @album_comment = AlbumComment.new
      @album_comments = AlbumComment.where(album_id: @album.id).order("id DESC").page(params[:page]).per(5)
      if user_signed_in?
        @album_rating = current_user.album_ratings.find_by(album_id: @album.id)
        @new_album_rating = current_user.album_ratings.new
      end
      @error = true
      render "user/spotify/album_show"
    end
  end

  def destroy
    comment = AlbumComment.find(params[:id])
    comment.destroy
    redirect_to user_spotify_album_show_path(comment.album_id)
  end


  private

  def album_comment_params
    params.require(:album_comment).permit(:comment)
  end

  def correct_user
    comment = AlbumComment.find(params[:id])
    unless current_user == comment.user
      redirect_to root_path
    end
  end

end
