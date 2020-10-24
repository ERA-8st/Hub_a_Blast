class User::BrowsingHistoryController < ApplicationController

  def index
    # @songs = SongImpression.where(user_id: current_user.id).select(:song_id, :user_id).distinct.order(updated_at: :desc)
    @songs = SongImpression.where(user_id: current_user.id).order(updated_at: :desc).pluck(:song_id).uniq
  end

end
