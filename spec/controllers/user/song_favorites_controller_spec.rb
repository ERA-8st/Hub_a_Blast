require 'rails_helper'

RSpec.describe User::SongFavoritesController, type: :controller do

  let(:user) { create(:user) }

  describe "index" do
    it "正常にレスポンスを返す" do
      get :index, params: { user_id: user }
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "create" do
    # context "ログインしている場合" do
    #   it "favoriteに保存される" do
    #     sign_in user
    #     expect{
    #       post :create, params: { song_id: "4VXIryQMWpIdGgYR4TrjT1" }
    #     }.to change(user.song_favorites , :count).by(1)
    #   end
    # end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        post :create, params: { song_id: "4VXIryQMWpIdGgYR4TrjT1" }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy" do
    let!(:song_favorite) { create(:song_favorite, user: user) }
    # context "ユーザーが適正な場合" do
    #   it "favoriteが削除される" do
    #     sign_in user
    #     expect{
    #       delete :destroy, params: { id: song_favorite }
    #     }.to change(user.song_favorites, :count).by(-1)
    #   end
    # end
    context "ユーザーが訂正でない場合" do
      it "topに遷移する" do
        delete :destroy, params: { id: song_favorite }
        expect(response).to redirect_to root_path
      end
    end
  end
  
end
