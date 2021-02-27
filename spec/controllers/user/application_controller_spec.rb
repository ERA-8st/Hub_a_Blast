require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let(:user) { create(:user) }
  let(:user2) { create(:user2) }

  describe "login_user_present?" do
    controller do
      def index
        redirect_to root_path unless user_signed_in?
      end
    end
    it "topに遷移する" do
      get :index
      expect(response).to redirect_to root_path
    end
  end

  describe "correct_comment_user" do
    controller do
      def index
        @url = params[:url]
        if @url.include? "/user/song_comments"
          @comment = SongComment.find(params[:id])
        elsif @url.include? "/user/album_comments"
          @comment = AlbumComment.find(params[:id])
        elsif @url.include? "/user/artist_comments"
          @comment = ArtistComment.find(params[:id])
        end
        redirect_to root_path unless current_user == @comment.user.id
      end
    end
    let!(:song_comment) { create(:song_comment, user: user) }
    let!(:album_comment) { create(:album_comment, user: user) }
    let!(:artist_comment) { create(:artist_comment, user:user) }
    it "@comment(song)が定義される" do
      get :index, params: { url: "/user/song_comments", id: song_comment}
      expect(controller.instance_variable_get("@comment")).to eq song_comment
      expect(response).to redirect_to root_path
    end
    it "@comment(album)が定義される" do
      get :index, params: { url: "/user/album_comments", id: album_comment, current_user_id: user.id }
      expect(controller.instance_variable_get("@comment")).to eq album_comment
      expect(response).to redirect_to root_path
    end
    it "@comment(artist)が定義される" do
      get :index, params: { url: "/user/artist_comments", id: artist_comment, current_user_id: user.id }
      expect(controller.instance_variable_get("@comment")).to eq artist_comment
      expect(response).to redirect_to root_path
    end
  end

  describe "add_count" do
    controller do
      def index
        @count = params[:count].blank? ? 4 : params[:count].to_i
      end
    end
    context "countが空の場合" do
      it "4を返す" do
        get :index, xhr: true
        expect(controller.instance_variable_get("@count")).to eq 4
      end
    end
    context "countが存在する場合" do
      it "countを返す" do
        get :index, params: { count: 8 },xhr: true
        expect(controller.instance_variable_get("@count")).to eq 8
      end
    end
  end

  describe "new_releases_search" do
    controller do
      def index
        if params[:country].blank?
          @albums = RSpotify::Album.new_releases
          @region = "all"
        else
          @albums = RSpotify::Album.new_releases(country: params[:country])
          @region = "#{params[:country]}"
        end
      end
    end
    context "指定がない場合" do
      it "new_releasesを返す" do
        get :index, xhr: true
        expect(controller.instance_variable_get("@albums").present?).to eq true
        expect(controller.instance_variable_get("@region")).to eq "all"
      end
    end
    context "指定がある場合" do
      it "new_release(country)を返す" do
        get :index, params: { country: "JP" },xhr: true
        expect(controller.instance_variable_get("@albums").present?).to eq true
        expect(controller.instance_variable_get("@region")).to eq "JP"
      end
    end    
  end

  describe "sort_charged_ups" do
    controller do
      def index
        case params[:time]
          when nil, "指定無し"
            charged_up = SongComment.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
          when "今日"
            charged_up = SongComment.day.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
            @time = "Today"
          when "１週間"
            charged_up = SongComment.week.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
            @time = "Week"
          when "一ヶ月"
            charged_up = SongComment.month.group(:song_id).count(:song_id).to_a.sort {|a,b| a[1] <=> b[1]}.reverse
            @time = "Month"
          end
      end
    end
    it "指定なしを返す" do
      get :index, xhr: true
      expect(controller.instance_variable_get("@time").present?).to eq false
      get :index, params: { time: "指定なし" }, xhr: true
      expect(controller.instance_variable_get("@time").present?).to eq false
    end
    it "Todayを返す" do
      get :index, params: { time: "今日" }, xhr: true
      expect(controller.instance_variable_get("@time")).to eq "Today"
    end
    it "Weekを返す" do
      get :index, params: { time: "１週間" }, xhr: true
      expect(controller.instance_variable_get("@time")).to eq "Week"
    end
    it "Monthを返す" do
      get :index, params: { time: "一ヶ月" }, xhr: true
      expect(controller.instance_variable_get("@time")).to eq "Month"
    end
  end
  
end
