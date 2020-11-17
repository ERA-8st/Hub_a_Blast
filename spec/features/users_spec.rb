require 'rails_helper'

RSpec.feature "Users", type: :feature do
  
  describe "User" do
    # describe "ユーザー新規登録" do
    #   before do
    #     visit new_user_registration_path
    #   end
    #   context "新規登録画面に遷移" do
    #     it "新規登録に成功する" do
    #       fill_in "user[email]", with: "test@test"
    #       fill_in "user[user_name]", with: "test_user"
    #       fill_in "user[password]", with: "password"
    #       fill_in "user[password_confirmation]", with: "password"
    #       click_button "Sign up"

    #       expect(User.all.count).to eq 1  
    #     end

    #     it "新規登録に失敗する" do
    #       fill_in "user[email]", with: ""
    #       fill_in "user[user_name]", with: ""
    #       fill_in "user[password]", with: ""
    #       fill_in "user[password_confirmation]", with: ""
    #       click_button "Sign up"

    #       expect(User.all.count).to eq 0  
    #     end
        
    #   end
    # end

    # describe "ユーザーログイン" do
    #   let(:user) { create(:user) }
    #   before do
    #     visit new_user_session_path
    #   end
    #   context "ログイン画面に遷移" do
    #     it "ログインに成功する" do
    #       fill_in "user_email", with: user.email
    #       fill_in "user_password", with: user.password
    #       click_button "Log in"

    #       expect(current_path).to eq root_path  
    #     end

    #     it "ログインに失敗する" do
    #       fill_in "user_email", with: ""
    #       fill_in "user_password", with: ""
    #       click_button "Log in"

    #       expect(current_path).to eq new_user_session_path
    #     end
    #   end
    # end
    
    describe "ユーザー詳細" do
      let(:user) { create(:user) }
      describe "ログインユーザーと詳細ユーザーが一致している場合" do
        before do
          visit new_user_session_path
          fill_in "user_email", with: user.email
          fill_in "user_password", with: user.password
          click_button "Log in"
          visit user_user_path(user.id)
        end
        context "表示のテスト" do
          context "ヘッダーのテスト" do
            let(:user_header) { find(".user-header")}
            context "表示のテスト" do
              it "ユーザー詳細リンクが表示される" do
                expect(user_header).to have_link "", href: user_user_path(user.id)
              end
              it "お気に入り一覧リンクが表示される" do
                expect(user_header).to have_link "", href: user_song_favorites_path(user_id: user.id)
              end
              it "ユーザー編集リンクが表示される" do
                expect(user_header).to have_link "", href: edit_user_user_path(user.id)  
              end
              it "通知一覧リンクが表示される" do
                expect(user_header).to have_link "", href: user_notifications_path
              end
            end
            
          end
        end
        
      end
      

    end
    
  end
  
end
