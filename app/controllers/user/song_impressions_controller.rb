class User::SongImpressionsController < ApplicationController

  def index
    @top_impressions = SongImpression.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
  end
end
