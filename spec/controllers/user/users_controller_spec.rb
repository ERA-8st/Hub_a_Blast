require 'rails_helper'

RSpec.describe User::UsersController, type: :controller do

  let(:user1) { create(:user) }
  let(:user2) { create(:user2) }

  describe "show" do
    it "正常にレスポンスを返す" do
      get :show, params: { id: user1.id }
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "edit" do
    context "編集対象とログインユーザーが一致してる場合" do
      it "遷移できる" do
        sign_in user1
        get :edit, params: { id: user1.id }
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
    context "編集対象とログインユーザーが異なる場合" do
      it "topページに遷移する" do
        sign_in user1
        get :edit, params: { id: user2.id }
        expect(response).to redirect_to root_path
      end
    end
    context "ユーザーがログインしていない場合" do
      it "topページに遷移する" do
        get :edit, params: { id: user1.id }
        expect(response).to redirect_to root_path  
      end
    end
  end

  describe "follow_index" do
    it "正常にレスポンスを返す" do
      get :follow_index, params: { id: user1.id }
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

  describe "follower_index" do
    it "正常にレスポンスを返す" do
      get :follower_index, params: { id: user1.id }
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end

end
