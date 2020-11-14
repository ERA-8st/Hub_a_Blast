require 'rails_helper'

RSpec.describe User::AlbumRatingsController, type: :controller do

  let(:user) { create(:user)}

  describe "create" do
    
    it "保存される" do
      album_rating_params = FactoryBot.attributes_for(:album_rating)
      sign_in user
      expect{ post :create , params: { album_rating: album_rating_params}, xhr: true}.to change(user.album_ratings, :count).by(1)
    end

    context "保存されなかった場合" do
      it "前画面へ遷移する" do
        album_rating_params = FactoryBot.attributes_for(:album_rating, rate: nil)
        sign_in user
        post :create , params: { album_rating: album_rating_params }
        expect(response).to redirect_to root_path  
      end
    end
    
  end

  describe "update" do

    let(:album_rating) { create(:album_rating, user_id: user.id)}

    it "更新される" do
      album_rating_params = FactoryBot.attributes_for(:album_rating, rate: 5)
      sign_in user
      patch :update, params: { id: album_rating.id, album_rating: album_rating_params }, xhr: true
      expect(album_rating.reload.rate).to eq 5  
    end

    context "更新されなかった場合" do
      it "前画面へ遷移する" do
        album_rating_params = FactoryBot.attributes_for(:album_rating, rate: nil)
        sign_in user
        patch :update, params: { id: album_rating.id, album_rating: album_rating_params }, xhr: true
        expect(response).to redirect_to root_path  
      end
    end
    

    context "ログインユーザーとratingユーザーが異なる場合" do
      it "topに遷移する" do
        user2 = FactoryBot.create(:user2)
        sign_in user2
        album_rating_params = FactoryBot.attributes_for(:album_rating, rate: 5)
        patch :update, params: { id: album_rating.id, album_rating: album_rating_params }, xhr: true
        expect(response).to redirect_to root_path
      end
    end
    
  end
  
end
