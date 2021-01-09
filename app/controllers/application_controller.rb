class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  require 'rspotify'
  RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

  def room_present?(user)
    if user_signed_in?
      @currentUserEntry = Entry.where(user_id: current_user.id)
      @userEntry = Entry.where(user_id: user.id)
      unless @user.id == current_user.id
        @currentUserEntry.each do |cu|
          @userEntry.each do |u|
            if cu.room_id == u.room_id then
              @isRoom = true
              @roomId = cu.room_id
            end
          end
        end
        unless @isRoom
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end

  def login_user_present?
    redirect_to root_path unless user_signed_in?
  end

  def correct_comment_user
    @url = request.url
    if @url.include? "/user/song_comments"
      @comment = SongComment.find(params[:id])
    elsif @url.include? "/user/album_comments"
      @comment = AlbumComment.find(params[:id])
    elsif @url.include? "/user/artist_comments"
      @comment = ArtistComment.find(params[:id])
    end
    redirect_to root_path unless current_user == @comment.user
  end

  def set_page
    @page = params[:page]
  end

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :user_name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
end
