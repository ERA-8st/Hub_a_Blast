require 'rails_helper'

RSpec.describe User::SongCommentsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  describe "create" do
    it "コメントが保存される" do
      song_comment_params = FactoryBot.attributes_for(:song_comment)
      sign_in user
      expect{ post :create , params: { song_comment: song_comment_params} }.to change(user.song_comments, :count).by(1)
    end
    context "コメントが保存されなかった場合" do
      it "エラーメッセージが表示される" do
        song_comment_params = FactoryBot.attributes_for(:song_comment, comment: nil )
        sign_in user
        post :create, params: { song_comment: song_comment_params }
        expect(response).to render_template "user/spotify/song_show"
      end
    end
    context "ログインしていない場合" do
      it "topに遷移する" do
        song_comment_params = FactoryBot.attributes_for(:song_comment)
        post :create , params: { song_comment: song_comment_params }
        expect(response).to redirect_to root_path  
      end
    end
  end

  describe "update" do
    
    let(:song_comment) { FactoryBot.create(:song_comment, user: user) }

    it "更新される" do
      song_comment_params = FactoryBot.attributes_for(:song_comment, comment: "hello!!" )
      sign_in user
      patch :update, params: { id: song_comment.id, song_comment: song_comment_params }
      expect(song_comment.reload.comment).to eq "hello!!"  
    end
    context "更新されなかった場合" do
      it "エラーメッセージが表示される" do
        song_comment_params = FactoryBot.attributes_for(:song_comment, comment: nil )
        sign_in user
        patch :update, params: { id: song_comment.id, song_comment: song_comment_params }
        expect(response).to render_template "user/spotify/song_show"
      end
    end
    context "ログインしていない場合" do
      it "topに遷移する" do
        song_comment_params = FactoryBot.attributes_for(:song_comment, comment: "hello!!" )
        patch :update, params: { id: song_comment.id, song_comment: song_comment_params }
        expect(response).to redirect_to root_path
      end
    end
    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        user2 = FactoryBot.create(:user2)
        sign_in user2
        song_comment_params = FactoryBot.attributes_for(:song_comment, comment: "hello!!" )
        patch :update, params: { id: song_comment.id, song_comment: song_comment_params }
        expect(response).to redirect_to root_path  
      end
    end
  end

  describe "destroy" do
    it "削除される" do
      sign_in user
      song_comment = FactoryBot.create(:song_comment, user: user )
      expect{ delete :destroy, params: { id: song_comment.id } }.to change(user.song_comments, :count).by(-1)
    end
    context "ログインしていない場合" do
      it "topに遷移する" do
        song_comment = FactoryBot.create(:song_comment, user: user )
        delete :destroy, params: { id: song_comment.id }
        expect(response).to redirect_to root_path
      end
    end
    context "ログインユーザーとコメントのユーザーが異なる場合" do
      it "topに遷移する" do
        song_comment = FactoryBot.create(:song_comment, user: user)
        user2 = FactoryBot.create(:user2)
        sign_in user2
        delete :destroy, params: { id: song_comment.id }
        expect(response).to redirect_to root_path
      end
    end
  end

end
