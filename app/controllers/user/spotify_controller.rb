class User::SpotifyController < ApplicationController

  before_action :set_page, only: [:artist_show, :album_show, :song_show]

  def index
    if params[:search].blank?
      redirect_back(fallback_location: root_path) 
    else
      @search_word = params[:search]
      @searchartists = RSpotify::Artist.search(@search_word)
      @searchalbums = RSpotify::Album.search(@search_word)
      @searchsongs = RSpotify::Track.search(@search_word)
      @artist_count = add_count(params[:artist_count])
      @album_count = add_count(params[:album_count])
      @song_count = add_count(params[:song_count])
    end
  end

  def artist_show
    @artist = RSpotify::Artist.find(params[:id])
    @albums = @artist.albums
    @artist_comment = ArtistComment.new
    @artist_comments = ArtistComment.includes(:user).where(artist_id: @artist.id).order("id DESC").page(params[:page]).per(5)
    @comment = ArtistComment.find(params[:comment_id]) if params[:comment_id].present?
  end

  def album_show
    @album = RSpotify::Album.find(params[:id])
    @songs = @album.tracks
    @album_comment = AlbumComment.new
    @album_comments = AlbumComment.includes(:user).where(album_id: @album.id).order("id DESC").page(params[:page]).per(5)
    @comment = AlbumComment.find(params[:comment_id]) if params[:comment_id].present?
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
    @song_comments = SongComment.includes(:user).where(song_id: @song.id).order("id DESC").page(params[:page]).per(5)
    @comment = SongComment.find(params[:comment_id]) if params[:comment_id].present?
    if user_signed_in?
      # 評価機能
      @song_rating = current_user.song_ratings.find_by(song_id: @song.id)
      @new_song_rating = current_user.song_ratings.new
      # PV機能
      current_user.create_song_impression(params[:id])
    end
    @song_favorite = SongFavorite.find_by(user_id: current_user, song_id: @song.id)
  end

  def new_releases
    @new_releases = new_releases_search(params[:country])
    @country_name = params[:country]
  end

  def charged_ups
    # 特定の期間内のコメントを取得して曲のIDの重複数が多い順に並び替えて取得
    case params[:times]
      when nil, "指定無し"
        @charged_up = SongComment.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
      when "今日"
        @charged_up = SongComment.day.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Today"
      when "１週間"
        @charged_up = SongComment.week.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Week"
      when "一ヶ月"
        @charged_up = SongComment.month.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Month"
      end
  end
  
end
