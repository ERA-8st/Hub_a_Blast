class User::SpotifyController < ApplicationController

	require 'rspotify'
	RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

	def index
		if params[:search].blank?
			redirect_back(fallback_location: root_path)
		end
		@search_word = params[:search]
		# アーティスト検索
			if @search_word.present?
				@searchartists = RSpotify::Artist.search(@search_word)
			end
			# 一覧表示件数
			if params[:artist_count].blank?
				@artist_count = 4
			else
				@artist_count = params[:artist_count].to_i
			end
		# アルバム検索
			if @search_word.present?
				@searchalbums = RSpotify::Album.search(@search_word)
			end
			# 一覧表示件数
			if params[:album_count].blank?
				@album_count = 4
			else
				@album_count = params[:album_count].to_i
			end
		# 楽曲検索
			if @search_word.present?
				@searchsongs = RSpotify::Track.search(@search_word)
			end
			# 一覧表示件数
			if params[:song_count].blank?
				@song_count = 4
			else
				@song_count = params[:song_count].to_i
			end
	end

	def artist_show
		@artist = RSpotify::Artist.find(params[:id])
		@albums = @artist.albums
		@artist_comment = ArtistComment.new
		@artist_comments = ArtistComment.where(artist_id: @artist.id)
		# コメント編集用
		if params[:comment_id].present?
			@comment = ArtistComment.find(params[:comment_id])
		end
		# 評価機能
		if user_signed_in?
			@artist_rating = current_user.artist_ratings.find_by(artist_id: @artist.id)
		@new_artist_rating = current_user.artist_ratings.new
		end
	end

	def album_show
		@album = RSpotify::Album.find(params[:id])
		@songs = @album.tracks
		@album_comment = AlbumComment.new
		@album_comments = AlbumComment.where(album_id: @album.id)
		# コメント編集用
		if params[:comment_id].present?
			@comment = AlbumComment.find(params[:comment_id])
		end
		# 評価機能
		if user_signed_in?
			@album_rating = current_user.album_ratings.find_by(album_id: @album.id)
			@new_album_rating = current_user.album_ratings.new
		end
	end

	def song_show
		@song = RSpotify::Track.find(params[:id])
		@album = @song.album
		@song_comment = SongComment.new
		@song_comments = SongComment.where(song_id: @song.id)
		# コメント編集用
		if params[:comment_id].present?
			@comment = SongComment.find(params[:comment_id])
		end
		# 評価機能
		if user_signed_in?
			@song_rating = current_user.song_ratings.find_by(song_id: @song.id)
		@new_song_rating = current_user.song_ratings.new
		end
	end
	
	def new_releases
		case params[:country]
			when nil || ""
				@new_releases = RSpotify::Album.new_releases
			# 国別 new_release
			else
				@new_releases = RSpotify::Album.new_releases(country: params[:country])
				@country_name = params[:country]
		end
	end
	
	
end
