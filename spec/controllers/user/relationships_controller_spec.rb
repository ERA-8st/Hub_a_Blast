require 'rails_helper'

RSpec.describe User::RelationshipsController, type: :controller do

  let(:user) { create(:user) }
  let(:user2) { create(:user2) }

  describe "create" do
    context "ログインしている場合" do
      it "フォローできる" do
        sign_in user
        expect{
          post :create , params: { relationship: { follow_id: user2 } }, xhr: true
        }.to change(user.relationships, :count).by(1)
      end
    end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        post :create
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "destroy" do
    let!(:relationship) { create(:relationship, user: user, follow: user2) }
    context "ログインしている場合" do
      it "フォローを解除できる" do
        sign_in user
        expect{
          delete :destroy, params: { id: relationship ,relationship: { follow_id: user2.id } }, xhr: true
        }.to change(user.relationships, :count).by(-1)
      end
    end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        delete :destroy, params: { id: relationship }
        expect(response).to  redirect_to new_user_session_path
      end
    end
  end
  
end
