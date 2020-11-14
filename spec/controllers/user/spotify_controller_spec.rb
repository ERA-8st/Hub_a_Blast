require 'rails_helper'

RSpec.describe User::SpotifyController, type: :controller do

  describe "index" do

    it "正常にレスポンスを返す" do
      get :index, params: { search: "a" }
      expect(response).to be_success
    end

    context "検索内容が空しない場合" do
      it "前画面へ遷移する" do
        get :index
        expect(response).to redirect_to root_path
      end
    end

  end

  describe "artist_show" do
    
    it "正常にレスポンスを返す" do
      get :artist_show, params: { id: "2MqhkhX4npxDZ62ObR5ELO" }
      expect(response).to be_success
    end

  end

  describe "albun_show" do
    
    it "正常にレスポンスを返す" do
      get :album_show, params: { id: "2zE1YKY7Okj10Tjl09jjth" }
      expect(response).to be_success  
    end

  end

  describe "song_show" do
    
    it "正常にレスポンスを返す" do
      get :song_show, params: { id: "2PnMMlB7UMaqQBYa1vGPHz" }
      expect(response).to be_success
    end

  end
  
  describe "new_releases" do
    
    it "正常にレスポンスを返す" do
      get :new_releases
      expect(response).to be_success
    end

  end
  
  describe "charged_ups" do
    
    it "正常にレスポンスを返す" do
      get :charged_ups
      expect(response).to be_success
    end
  end
  
end
