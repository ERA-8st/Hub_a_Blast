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
        if @isRoom
        else
          @room = Room.new
          @entry = Entry.new
        end
      end
    end
  end
  

  protected

  def configure_permitted_parameters
    added_attrs = [ :email, :user_name, :password, :password_confirmation ]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
  
end
