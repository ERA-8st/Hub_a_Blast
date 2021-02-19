require 'rails_helper'

RSpec.describe User::NotificationsController, type: :controller do

  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  let!(:notification) { create(:follow_notification, visited: user, visiter: user2) }

  describe "index" do
    context "ログインしている場合" do
      before do
        sign_in user
      end
      it "正常にレスポンスを返す" do
        get :index
        expect(response).to be_successful
        expect(response).to have_http_status "200"
      end
      it "nofificaitonのchackedがtrueになる" do
        expect(notification.checked).to eq false
        get :index
        expect(notification.reload.checked).to eq true
      end
    end
    context "ログインしていない場合" do
      it "ログイン画面に遷移する" do
        get :index
        expect(response).to redirect_to new_user_session_path
      end
    end
    
  end
  
end
