require 'rails_helper'

RSpec.describe User::AlbumCommentsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  describe "create" do
    
    it "コメントが保存される" do
      album_comment_params = FactoryBot.attributes_for(:album_comment)
      sign_in user
      expect{ post :create , params: { album_comment: album_comment_params }}.to change(user.album_comments, :count).by(1)  
    end

    context "コメントが保存されなかった場合" do
      it "エラーメッセージが表示される" do
        album_comment_params = FactoryBot.attributes_for(:album_comment, comment: nil)
        sign_in user
        post :create , params: { album_comment: album_comment_params }
        expect(response).to render_template "user/spotify/album_show"
      end
    end
    

    context "ログインしていない場合" do
      it "topに遷移する" do
        album_comment_params = FactoryBot.attributes_for(:album_comment)
        post :create , params: { album_comment: album_comment_params }
        expect(response).to redirect_to root_path
      end
    end
    
  end

  describe "update" do

    let(:album_comment){ FactoryBot.create(:album_comment, user: user)}
    
    it "更新される" do
      album_comment_params = FactoryBot.attributes_for(:album_comment, comment: "hello!!" )
      sign_in user
      patch :update, params: { id: album_comment.id, album_comment: album_comment_params }
      expect(album_comment.reload.comment).to eq "hello!!"
    end

    context "更新されなかった場合" do
      it "エラーメッセージが表示される" do
        album_comment_params = FactoryBot.attributes_for(:album_comment, comment: nil )
        sign_in user
        patch :update, params: { id: album_comment.id, album_comment: album_comment_params }
        expect(response).to render_template "user/spotify/album_show"
      end
    end
    

    context "ログインしていない場合" do
      it "topに遷移する" do
        album_comment_params = FactoryBot.attributes_for(:album_comment, comment: "hello!!" )
        patch :update, params: { id: album_comment.id, album_comment: album_comment_params }
        expect(response).to redirect_to root_path  
      end
    end

    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        user2 = FactoryBot.create(:user2)
        sign_in user2
        album_comment_params = FactoryBot.attributes_for(:album_comment, comment: "hello!!" )
        patch :update, params: { id: album_comment.id, album_comment: album_comment_params }
        expect(response).to redirect_to root_path  
      end
    end
    
  end

  describe "destroy" do

    it "削除される" do
      sign_in user
      album_comment = FactoryBot.create(:album_comment, user: user )
      expect{ delete :destroy ,params: { id: album_comment.id } }.to change(user.album_comments, :count).by(-1)
    end

    context "ログインしていない場合" do
      it "topに遷移する" do
        album_comment = FactoryBot.create(:album_comment, user: user )
        delete :destroy, params: { id: album_comment.id }
        expect(response).to redirect_to root_path  
      end
    end

    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        album_comment = FactoryBot.create(:album_comment, user: user )
        user2 = FactoryBot.create(:user2)
        sign_in user2
        delete :destroy, params: { id: album_comment.id }
        expect(response).to redirect_to root_path
      end
    end

  end
  
end
