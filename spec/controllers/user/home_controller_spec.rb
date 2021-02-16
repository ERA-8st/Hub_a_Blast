require 'rails_helper'

RSpec.describe User::HomeController, type: :controller do

  describe "top" do
    it "正常にレスポンスを返す" do
      get :top
      expect(response).to be_successful
      expect(response).to have_http_status "200"
    end
  end
  describe "about" do
    it "正常にレスポンスを返す" do
      get :about
      expect(response).to be_successful
    end
  end
end
