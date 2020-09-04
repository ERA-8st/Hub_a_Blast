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
    end

    def album_show
        @album = RSpotify::Album.find(params[:id])
        @songs = @album.tracks
    end

    def song_show
        @song = RSpotify::Track.find(params[:id])
        @album = @song.album
    end
    
    
    
end
