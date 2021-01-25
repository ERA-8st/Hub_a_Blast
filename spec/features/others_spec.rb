require 'rails_helper'

describe "その他のテスト" do
  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  before do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    visit user_inquiry_path
  end
  # describe "問い合わせのテスト" do
  #   context "ログインしていない場合" do
  #     before do
  #       click_link "LOG_OUT"
  #     end
  #     it "Topに遷移する" do
  #       visit user_inquiry_path
  #       expect(current_path).to eq new_user_session_path
  #     end
  #   end
  #   context "ログインしている場合" do
  #     it "問い合わせができる" do
  #       expect(current_path).to eq user_inquiry_path
  #       fill_in "inquiry_message", with: "test_inquiry"
  #       click_button "確認"
  #       expect(find("#new_inquiry")).to have_content user.user_name
  #       expect(find("#new_inquiry")).to have_content user.email
  #       expect(find("#new_inquiry")).to have_content "test_inquiry"
  #       click_button "送信"
  #       expect(page).to have_content "お問い合わせいただきありがとうございました。"
  #     end
  #     it "エラ〜メッセージが出る" do
  #       click_button "確認"
  #       expect(page).to have_content "お問い合わせ内容を入力してください"
  #     end
  #   end
  # end
  describe "フォロー一覧のテスト" do
    context "ユーザーをフォローしている場合" do
      let!(:relationship) { create(:relationship, user: user, follow: user2) }
      it "フォローユーザー一覧が表示される" do
        visit user_users_follow_index_path(user)
        expect(page).to have_link user2.user_name, href: user_user_path(user2)
        expect(page).to have_selector "form.edit_relationship"
      end
      context "ログインしていない場合" do
        it "フォローボタンが表示されない" do
          click_button "LOG_OUT"
          visit_user_users_follow_index_path(user)
          expect(page).to have__link user2.user_name, href: user_user_path(user2)
          expect(page).to_not have_selector "form.edit_relationship"
        end
      end
    end
    context "ユーザーをフォローしていない場合" do
      it "テキストが表示される" do
        visit user_users_follow_index_path(user)
        expect(page).to have_content "ユーザーをフォローしていません"
      end
    end
  end
  describe "フォロワー一覧のテスト" do
    context "フォロワーがいる場合" do
      it "フォロワー一覧が表示される" do
        
      end
      it "フォローボタンが表示されない" do
        
      end
    end
    context "フォロワーがいない場合" do
      it "テキストが表示される" do
        
      end
    end
  end

end