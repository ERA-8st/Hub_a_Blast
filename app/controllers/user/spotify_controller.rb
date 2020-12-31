class User::SpotifyController < ApplicationController

  before_action :set_page, only: [:artist_show, :album_show, :song_show]

  def index
    redirect_back(fallback_location: root_path) if params[:search].blank?
    @searchartists = RSpotify::Artist.search(params[:search])
    @searchalbums = RSpotify::Album.search(params[:search])
    @searchsongs = RSpotify::Track.search(params[:search])
    params[:artist_count].blank? ? @artist_count = 4 : @artist_count = params[:artist_count].to_i
    params[:album_count].blank? ? @album_count = 4 : @album_count = params[:album_count].to_i
    params[:song_count].blank? ? @song_count = 4 : @song_count = params[:song_count].to_i
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
    case params[:country]
      when nil || ""
        @new_releases = RSpotify::Album.new_releases
      else
        @new_releases = RSpotify::Album.new_releases(country: params[:country])
        @country_name = params[:country]
    end
  end

  def charged_ups
    # 特定の期間内のコメントを取得して曲のIDの重複数が多い順に並び替えて取得
    case params[:times]
      when nil, "指定無し"
        @charged_up = SongComment.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
      when "今日"
        @charged_up = SongComment.where(created_at: Time.zone.now.all_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Today"
      when "１週間"
        @charged_up = SongComment.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Week"
      when "一ヶ月"
        @charged_up = SongComment.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Month"
      end
  end

  private

  def set_page
    @page = params[:page]
  end
  
end
