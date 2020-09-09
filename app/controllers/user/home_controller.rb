class User::HomeController < ApplicationController

	require 'rspotify'
	RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

	def top
		if current_user.present?
			@song_comments = current_user.song_comments.order("id DESC").select(:song_id).distinct.limit(3)
		end
		@new_releases =  RSpotify::Album.new_releases
		@new_releases_in_jp =  RSpotify::Album.new_releases(country: 'JP')
	end

	def about
		
	end

	def inquiry
		
	end
    
end