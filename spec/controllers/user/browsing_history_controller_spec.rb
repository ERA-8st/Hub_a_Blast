require 'rails_helper'

RSpec.describe User::BrowsingHistoryController, type: :controller do

  let(:user) { create(:user) }
  let(:song_impression) { create(:song_impression, user: user) }

  describe "index" do
    it "正常にレスポンスを返す" do
      sign_in user
      get :index
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
  
end