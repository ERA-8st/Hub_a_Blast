class User::SpotifyController < ApplicationController

    require 'rspotify'
    RSpotify.authenticate(ENV['SPOTIFY_CLIENT_ID'], ENV['SPOTIFY_SECRET_ID'])

    def index
        @search_word = params[:search]
        # アーティスト検索
            if @search_word.present?
                @searchartists = RSpotify::Artist.search(@search_word)
            end
            if params[:artist_count].blank?
                @artist_count = 4
            else
                @artist_count = params[:artist_count].to_i
            end
        # アルバム検索
            if @search_word.present?
                @searchalbums = RSpotify::Album.search(@search_word)
            end
            if params[:album_count].blank?
                @album_count = 4
            else
                @album_count = params[:album_count].to_i
            end
        # 楽曲検索
            if @search_word.present?
                @searchsongs = RSpotify::Track.search(@search_word)
            end
            if params[:song_count].blank?
                @song_count = 4
            else
                @song_count = params[:song_count].to_i
            end
    end
end
