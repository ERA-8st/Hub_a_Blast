require 'rails_helper'

RSpec.describe User::SongRatingsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  describe "create" do
    it "保存される" do
      song_rating_params = FactoryBot.attributes_for(:song_rating)
      sign_in user
      expect{ post :create , params: { song_rating: song_rating_params }, xhr: true}.to change(user.song_ratings, :count).by(1)  
    end
    context "保存されなかった場合" do
      it "前画面へ遷移する" do
        song_rating_params = FactoryBot.attributes_for(:song_rating, rate: nil)
        sign_in user
        post :create , params: { song_rating: song_rating_params }
        expect(response).to redirect_to root_path
      end
    end
  end

  describe "update" do
    
    let(:song_rating) { FactoryBot.create(:song_rating, user: user) }

    it "更新される" do
      song_rating_params = FactoryBot.attributes_for(:song_rating, rate: 5)
      sign_in user
      patch :update, params: { id: song_rating.id, song_rating: song_rating_params }, xhr: true
      expect(song_rating.reload.rate).to eq 5
    end
    context "更新されなかった場合" do
      it "前画面へ遷移する" do
        song_rating_params = FactoryBot.attributes_for(:song_rating, rate: nil)
        sign_in user
        patch :update, params: { id: song_rating.id, song_rating: song_rating_params }, xhr: true
        expect(response).to redirect_to root_path
      end
    end
    context "ログインユーザーとratingユーザーが異なる場合" do
      it "topに遷移する" do
        user2 = FactoryBot.create(:user2)
        sign_in user2
        song_rating_params = FactoryBot.attributes_for(:song_rating, rate: 5)
        patch :update, params: { id: song_rating.id, song_rating: song_rating_params }, xhr: true
        expect(response).to redirect_to root_path
      end
    end
  end
  
end
