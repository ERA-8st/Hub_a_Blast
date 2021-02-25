class User::AlbumCommentsController < ApplicationController

  before_action :login_user_present?
  before_action :correct_comment_user, only: [:update, :destroy]
  before_action :set_page, except: [:destroy]

  def create
    @album_comment = current_user.album_comments.new(album_comment_params)
    @album_comment.album_id = params[:album_comment][:album_id]
    if @album_comment.save 
      redirect_to user_spotify_album_show_path(@album_comment.album_id, page: @page)
    else
      set_error_variables(@album_comment.album_id, params[:page])
    end
  end

  def update
    if @comment.update(album_comment_params)
      redirect_to user_spotify_album_show_path(@comment.album_id, page: @page)
    else
      @album_comment = AlbumComment.new
      set_error_variables(@comment.album_id, params[:page])
    end
  end

  def destroy
    @comment.destroy
    redirect_to user_spotify_album_show_path(@comment.album_id)
  end

  def set_error_variables(album_id, page_params)
    @album = RSpotify::Album.find(album_id)
    @songs = @album.tracks
    @album_comments = AlbumComment.where(album_id: @album.id).order("id DESC").page(page_params).per(5)
    if user_signed_in?
      @album_rating = current_user.album_ratings.find_by(album_id: @album.id)
      @new_album_rating = current_user.album_ratings.new
    end
    @error = true
    render "user/spotify/album_show"
  end

  private

  def album_comment_params
    params.require(:album_comment).permit(:comment)
  end
  

end
