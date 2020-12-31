class User::HomeController < ApplicationController

  def top
    @song_comments = current_user.song_comments.order("id DESC").select(:song_id).distinct.limit(3) if current_user.present?
    @new_releases =  RSpotify::Album.new_releases
    @new_releases_in_jp =  RSpotify::Album.new_releases(country: 'JP')
    @charged_up = SongComment.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
  end

  def about
    
  end

end