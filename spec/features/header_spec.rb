require 'rails_helper'

describe "ヘッダーのテスト" do

  describe "ログインしていない場合" do
    before do
      visit root_path
    end
    context "表示のテスト" do
      let(:header) { all("header")[0] }
      it "外部リンクが表示される" do
        expect(header).to have_link "", href: "https://www.spotify.com/jp/"
      end
      it "TOPリンクが表示される" do
        expect(header).to have_link "TOP", href: user_home_top_path, id: "header_top"
      end
      it "ABOUTリンクが表示される" do
        expect(header).to have_link "ABOUT", href: user_home_about_path, id: "header_about"
      end
      it "SIGN_INリンクが表示される" do
        expect(header).to have_link "SIGN_IN", href: new_user_registration_path, id: "header_sign_in"
      end
      it "LOG_INリンクが表示される" do
        expect(header).to have_link "LOG_IN", href: new_user_session_path, id: "header_log_in"
      end
      it "検索フォームが表示される" do
        expect(header).to have_field "search"  
      end
      it "ユーザー名(Guest)が表示される" do
        expect(header).to have_content "Guest"  
      end
      it "ゲスト画像(log_inリンク)が表示される" do
        guest_user_img = find_link("guest_user_img")
        expect(guest_user_img).to have_selector "img[src$='/assets/no-image-a8970a4d625bc37c078b5c74f8e6f65c9ad2110f5089a90c4b638e1d41cebc4b.png']"
      end
    end
    context "リンクの確認" do
      it "TOPに遷移する" do
        click_link "header_top" 
        expect(current_path).to eq user_home_top_path  
      end
      it "ABOUTに遷移する" do
        click_link "header_about"
        expect(current_path).to eq user_home_about_path
      end
      it "新規登録画面に遷移する" do
        click_link "header_sign_in"
        expect(current_path).to eq new_user_registration_path 
      end
      it "ログイン画面に遷移する" do
        click_link "header_log_in"
        expect(current_path).to eq new_user_session_path  
      end
      context "検索フォームに入力済み" do
        it "indexに遷移" do
          fill_in "search" , with: "a"
          click_button "検索"
          expect(current_path).to eq user_spotify_index_path 
        end
      end
      context "検索フォームが空" do
        it "topに遷移" do
          click_button "検索"
          expect(current_path).to eq root_path
        end
      end
      it "ログイン画面に遷移する(ゲスト画像)" do
        click_link "guest_user_img"
        expect(current_path).to eq new_user_session_path
      end
      
    end
    
  end
  
  describe "ログインしている場合" do
    let(:user) { create(:user) }
    before do
      visit new_user_session_path
      fill_in "user_email", with: user.email
      fill_in "user_password", with: user.password
      click_button "Log in"
    end
    let(:header) { all("header")[0] }
    context "表示のテスト" do
      it "外部リンクが表示される" do
        expect(header).to have_link "", href: "https://www.spotify.com/jp/"
      end
      it "TOPリンクが表示される" do
        expect(header).to have_link "TOP", href: user_home_top_path, id: "header_top" 
      end
      it "ABOUTリンクが表示される" do
        expect(header).to have_link "ABOUT", href: user_home_about_path, id: "header_about"
      end
      it "INQUIRYリンクが表示される" do
        expect(header).to have_link "INQUIRY", href: user_inquiry_index_path, id: "header_inquiry"
      end
      it "LOG_OUTリンクが表示される" do
        expect(header).to have_link "LOG_OUT", href: destroy_user_session_path, id: "header_log_out"
      end
      it "検索フォームが表示される" do
        expect(header).to have_field "search" 
      end
      it "ユーザー名が表示される" do
        expect(header).to have_content "#{user.user_name}"
      end
      it "ユーザー画像が表示される" do
        guest_user_img = find_link("header-user-image")
        expect(guest_user_img).to have_selector "img[src$='/assets/no-image-a8970a4d625bc37c078b5c74f8e6f65c9ad2110f5089a90c4b638e1d41cebc4b.png']"
      end
    end
    context "リンクの確認" do
      it "TOPに遷移する" do
        click_link "header_top"
        expect(current_path).to eq user_home_top_path  
      end
      it "ABOUTに遷移する" do
        click_link "header_about"
        expect(current_path).to eq user_home_about_path  
      end
      it "INQUIRYに遷移する" do
        click_link "header_inquiry"
        expect(current_path).to eq user_inquiry_index_path
      end
      it "ログアウトができる" do
        click_link "header_log_out"
        expect(current_path).to eq root_path
        expect(header).to have_content "Guest"  
      end
      context "検索フォームに入力済み" do
        it "indexに遷移" do
          fill_in "search" , with: "a"
          click_button "検索"
          expect(current_path).to eq user_spotify_index_path 
        end
      end
      context "検索フォームが空" do
        it "topに遷移" do
          click_button "検索"
          expect(current_path).to eq root_path
        end
      end
      it "ユーザー詳細に遷移する" do
        click_link "header-user-image"
        expect(current_path).to eq user_user_path(user.id) 
      end
    end
    
  end
  
end

