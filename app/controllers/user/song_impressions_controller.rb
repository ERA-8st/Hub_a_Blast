class User::SongImpressionsController < ApplicationController

  def index
    case params[:times]
      when nil, "指定無し"
        @top_impressions = SongImpression.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
      when "今日"
        @top_impressions = SongImpression.where(created_at: Time.zone.now.all_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Today"
      when "１週間"
        @top_impressions = SongImpression.where(created_at: 1.week.ago.beginning_of_day..Time.zone.now.end_of_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Week"
      when "一ヶ月"
        @top_impressions = SongImpression.where(created_at: 1.month.ago.beginning_of_day..Time.zone.now.end_of_day).group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
        @time = "Month"
    end
  end
end
