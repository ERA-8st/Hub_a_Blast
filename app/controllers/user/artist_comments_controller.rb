class User::ArtistCommentsController < ApplicationController

  before_action :login_user_present?
  before_action :correct_comment_user, only: [:update, :destroy]
  before_action :set_page, except: [:destroy]

  def create
    @artist_comment = current_user.artist_comments.new(artist_comment_params)
    @artist_comment.artist_id = params[:artist_comment][:artist_id]
    if @artist_comment.save 
      redirect_to user_spotify_artist_show_path(@artist_comment.artist_id, page: @page)
    else
      set_error_variables(params[:artist_comment][:artist_id], params[:page])
    end
  end

  def update
    if @comment.update(artist_comment_params)
      redirect_to user_spotify_artist_show_path(@comment.artist_id, page: @page)
    else
      @artist_comment = ArtistComment.new
      set_error_variables(@comment.artist_id, params[:page])
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to user_spotify_artist_show_path(@comment.artist_id)
  end

  def set_error_variables(artist_id, page_params)
    @artist = RSpotify::Artist.find(artist_id)
    @albums = @artist.albums
    @artist_comments = ArtistComment.where(artist_id: @artist.id).order("id DESC").page(page_params).per(5)
    @error = true
    render "user/spotify/artist_show"
  end

  private

  def artist_comment_params
    params.require(:artist_comment).permit(:comment)
  end

end
