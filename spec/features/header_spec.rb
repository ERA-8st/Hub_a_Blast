require 'rails_helper'

describe "ヘッダーのテスト" do

  context "ログインしていない場合" do
    before do
      visit root_path
    end
    let(:header) { find("header") }
    it "外部リンクが表示される" do
      expect(header).to have_link "", href: "https://www.spotify.com/jp/"
    end
    it "TOPリンクが表示され正しく機能している" do
      expect(header).to have_link "TOP", href: user_home_top_path, id: "header_top"
      click_link "header_top" 
      expect(current_path).to eq user_home_top_path
    end
    it "ABOUTリンクが表示され正しく機能している" do
      expect(header).to have_link "ABOUT", href: user_home_about_path, id: "header_about"
      click_link "header_about"
      expect(current_path).to eq user_home_about_path
    end
    it "SIGN_INリンクが表示され正しく機能している" do
      expect(header).to have_link "SIGN_IN", href: new_user_registration_path, id: "header_sign_in"
      click_link "header_sign_in"
      expect(current_path).to eq new_user_registration_path 
    end
    it "LOG_INリンクが表示され正しく機能している" do
      expect(header).to have_link "LOG_IN", href: new_user_session_path, id: "header_log_in"
      click_link "header_log_in"
      expect(current_path).to eq new_user_session_path
    end
    it "検索フォームが表示される" do
      expect(header).to have_field "search"  
    end
    context "検索(フォーム入力済み)" do
      it "indexに遷移" do
        fill_in "search" , with: "a"
        click_button "検索"
        expect(current_path).to eq user_spotify_index_path 
      end
    end
    context "検索(フォーム未入力)" do
      it "topに遷移" do
        click_button "検索"
        expect(current_path).to eq root_path
      end
    end
    it "ゲストログイン用リンクが表示されゲストとしてログインできる" do
      expect(header).to have_link  "guest-login", href: users_guest_sign_in_path
      click_link "guest-login", href: users_guest_sign_in_path
      expect(header).to have_content "Guest"
    end
  end
  context "ログインしている場合" do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end
    let(:header) { find("header") }
    it "外部リンクが表示される" do
      expect(header).to have_link "", href: "https://www.spotify.com/jp/"
    end
    it "TOPリンクが表示され正しく機能している" do
      expect(header).to have_link "TOP", href: user_home_top_path, id: "header_top" 
      click_link "header_top"
      expect(current_path).to eq user_home_top_path
    end
    it "ABOUTリンクが表示され正しく機能している" do
      expect(header).to have_link "ABOUT", href: user_home_about_path, id: "header_about"
      click_link "header_about"
      expect(current_path).to eq user_home_about_path 
    end
    it "INQUIRYリンクが表示され正しく機能している" do
      expect(header).to have_link "INQUIRY", href: user_inquiry_index_path, id: "header_inquiry"
      click_link "header_inquiry"
      expect(current_path).to eq user_inquiry_index_path
    end
    it "LOG_OUTリンクが表示されログアウトできる" do
      expect(header).to have_link "LOG_OUT", href: destroy_user_session_path, id: "header_log_out"
      click_link "header_log_out"
      expect(current_path).to eq root_path
      expect(header).to have_link "guest-login", href: users_guest_sign_in_path
    end
    it "検索フォームが表示される" do
      expect(header).to have_field "search" 
    end
    context "検索(フォーム入力済み)" do
      it "indexに遷移" do
        fill_in "search" , with: "a"
        click_button "検索"
        expect(current_path).to eq user_spotify_index_path 
      end
    end
    context "検索(フォーム未入力)" do
      it "topに遷移" do
        click_button "検索"
        expect(current_path).to eq root_path
      end
    end
    it "ユーザー情報が表示され詳細へ遷移する" do
      expect(header).to have_content "#{user.user_name}"
      expect(find_link("header-user-image")).to have_selector "img[src$='/assets/no-image-a8970a4d625bc37c078b5c74f8e6f65c9ad2110f5089a90c4b638e1d41cebc4b.png']"
      click_link "header-user-image"
      expect(current_path).to eq user_user_path(user.id) 
    end
  end
end

