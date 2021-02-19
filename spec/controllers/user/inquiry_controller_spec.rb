require 'rails_helper'

RSpec.describe User::InquiryController, type: :controller do

  let(:user) { create(:user) }

  describe "index" do
    context "ログインしている場合" do
      it "正常にレスポンスを返す" do
        sign_in user
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
    context "ログインしていない場合" do
      it "topに遷移する" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "confirm" do
    context "ログインしている場合" do
      before do
        sign_in user
      end
      it "正常にレスポンスを返す" do
        get :confirm, params: { inquiry: { name: user.user_name, email: user.email, message: "test_message"} }
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
      it "indexに遷移する" do
        get :confirm, params: { inquiry: { name: user.user_name, email: user.email, message: ""} }
        expect(response).to render_template(:index)
      end
    end
    context "ログインしていない場合" do
      it "topに遷移する" do
        get :confirm, params: { inquiry: { name: user.user_name, email: user.email, message: "test_message"} }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "create" do
    context "ログインしている場合" do
      before do
        sign_in user
      end
      it "thanksに遷移する" do
        post :create, params: { inquiry: { name: user.user_name, email: user.email, message: "test_message"} }
        expect(response).to redirect_to user_inquiry_thanks_path
      end
      it "indexに遷移する" do
        post :create, params: { inquiry: { name: user.user_name, email: user.email, message: ""} }
        expect(response).to redirect_to user_inquiry_index_path
      end
    end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        post :create, params: { inquiry: { name: user.user_name, email: user.email, message: ""} }
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "thanks" do
    context "ログインしている場合" do
      it "正常にレスポンスを返す" do
        sign_in user
        get :thanks
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
    end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        get :thanks
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
  
end