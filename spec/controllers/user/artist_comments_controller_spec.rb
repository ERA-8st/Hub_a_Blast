require 'rails_helper'

RSpec.describe User::ArtistCommentsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  describe "create" do
    
    it "コメントが保存される" do
      artist_comment_params = FactoryBot.attributes_for(:artist_comment)
      sign_in user
      expect{ post :create , params: { artist_comment: artist_comment_params }}.to change(user.artist_comments, :count).by(1)
    end

    context "コメントが保存されなかった場合" do
      it "エラーメッセージが表示される" do
        artist_comment_params = FactoryBot.attributes_for(:artist_comment, comment: nil)
        sign_in user
        post :create, params: { artist_comment: artist_comment_params }
        expect(response).to render_template "user/spotify/artist_show"
      end
    end

    context "ログインしていない場合" do
      it "topに遷移する" do
        artist_comment_params = FactoryBot.attributes_for(:artist_comment)
        post :create , params: { artist_comment: artist_comment_params }
        expect(response).to redirect_to root_path  
      end
    end
    
  end

  describe "update" do

    let(:artist_comment) { FactoryBot.create(:artist_comment, user:user)}
    
    it "更新される " do
      artist_comment_params = FactoryBot.attributes_for(:artist_comment, comment: "hello!!")
      sign_in user
      patch :update, params: { id: artist_comment.id, artist_comment: artist_comment_params }
      expect(artist_comment.reload.comment).to  eq "hello!!"
    end

    context "更新されなかった場合" do
      it "エラーメッセージが表示される" do
        artist_comment_params = FactoryBot.attributes_for(:artist_comment, comment: nil )
        sign_in user
        patch :update, params: { id: artist_comment.id, artist_comment: artist_comment_params }
        expect(response).to  render_template "user/spotify/artist_show"
      end
    end
    

    context "ログインしていない場合" do
      it "topに遷移する" do 
        artist_comment_params = FactoryBot.attributes_for(:artist_comment, comment: "hello!!")
        patch :update, params: { id: artist_comment.id, artist_comment: artist_comment_params }
        expect(response).to redirect_to root_path 
      end
    end

    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        user2 = FactoryBot.create(:user2)
        sign_in user2
        artist_comment_params = FactoryBot.attributes_for(:artist_comment, comment: "hello!!" )
        patch :update, params: { id: artist_comment.id, artist_comment: artist_comment_params }
        expect(response).to redirect_to root_path 
      end
    end
    
  end

  describe "destroy" do
    
    it "削除される" do
      sign_in user
      artist_comment = FactoryBot.create(:artist_comment, user: user )
      expect{ delete :destroy , params: { id: artist_comment.id } }.to change(user.artist_comments, :count).by(-1)
    end

    context "ログインしていない場合" do
      it "topに遷移する" do
        artist_comment = FactoryBot.create(:artist_comment, user: user)
        delete :destroy, params: { id: artist_comment.id }
        expect(response).to redirect_to root_path
      end
    end

    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        artist_comment = FactoryBot.create(:artist_comment, user: user)
        user2 = FactoryBot.create(:user2)
        sign_in user2
        delete :destroy, params: { id: artist_comment.id }
        expect(response).to redirect_to root_path
      end
    end
    
  end
  
end
