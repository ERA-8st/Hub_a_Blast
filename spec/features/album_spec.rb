require 'rails_helper'

describe "アルバムのテスト" do
  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  let!(:album_comment) { create(:album_comment, user: user) }
  let!(:album_comment2) { create(:album_comment2, user: user2) }
  before do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    visit user_spotify_album_show_path("0qsh1whWV3FcVaM6A8vLN9")
  end
  describe "アルバム詳細のテスト" do
    context "タイトルのテスト" do
      let(:title) { find(".head_title") }
      it "タイトル、リンクが正しく表示される" do
        expect(title).to have_content "Stand Up"
        expect(title).to have_link "Various Artists"
        title.click_link "Various Artists"
        expect(current_path).to eq user_spotify_artist_show_path("0LyfQWJT6nXafLPZqxe9Of")
      end
    end
    context "詳細のテスト" do
      let(:album_show) { find(".album-show-left") }
      it "各種情報が正しく表示される" do
        expect(album_show).to have_selector "img[src$='https://i.scdn.co/image/ab67616d00001e02dff995e4ae99b3bc0830331f']"
        expect(album_show).to have_content "Stand Up"
        expect(album_show).to have_selector ".fb-share-button"
        expect(album_show).to have_selector(".line-it-button", visible: false)
        expect(album_show).to have_selector ".twitter-share-button"
        expect(album_show).to have_selector ".album_rating"
      end
      context "ログインしていない場合" do
        before do
          click_link "LOG_OUT"
          visit user_spotify_album_show_path("0qsh1whWV3FcVaM6A8vLN9")
        end
        it "評価機能が表示されない" do
          expect(album_show).to_not have_selector ".album_rating"
        end
      end
    end
    context "曲一覧のテスト" do
      it "全て正しく表示される" do
        expect(all("tr").count).to eq 8
      end
    end
    
    context "コメントのテスト" do
      let(:album_show_comments) { find(".album-show-right") }
      context "表示のテスト" do
        it "コメントが全て表示される" do
          expect(all(".comment").count).to eq 2
          expect(page).to have_content album_comment.comment
          expect(page).to have_content album_comment2.comment
        end
        it "コメント数が表示される" do
          expect(page).to have_content "2コメント"
        end
      end
      context "投稿のテスト" do
        it "成功する" do
          expect{
            fill_in "album_comment_comment", with: "test"
            click_button "コメント"
          }.to change(user.album_comments, :count).by(1)
        end
        it "失敗する" do
          expect{
            fill_in "album_comment_comment", with: ""
            click_button "コメント"
            expect(album_show_comments).to have_content "コメントを入力してください"
          }.to change(user.album_comments, :count).by(0)
        end
        it "フォームが表示されない" do
          expect(album_show_comments).to have_selector "textarea#album_comment_comment"
          expect(album_show_comments).to have_selector "input[value='コメント']"
          click_link "LOG_OUT"
          visit user_spotify_album_show_path("0qsh1whWV3FcVaM6A8vLN9")
          expect(album_show_comments).to_not have_selector "textarea#album_comment_comment"
          expect(album_show_comments).to_not have_selector "input[value='コメント']"
        end
      end
      context "更新のテスト" do
        before do
          click_link "album_comment#{album_comment.id}_edit"
        end
        it "成功する" do
          fill_in "album_comment#{album_comment.id}_edit_form", with: "changed_album_comment"
          click_button "更新する"
          expect(album_comment.reload.comment).to eq "changed_album_comment"
        end
        it "失敗する" do
          fill_in "album_comment#{album_comment.id}_edit_form", with: ""
          click_button "更新する"
          expect(album_show_comments).to have_content "コメントを入力してください"
        end
        it "取り消せる" do
          fill_in "album_comment#{album_comment.id}_edit_form", with: "chenged_album_comment"
          click_link "取り消し"
          expect(page).to_not have_selector "textarea#album_comment#{album_comment.id}_edit_form"
          expect(album_comment.reload.comment).to eq "album_comment_test"
        end
        it "表示されない" do
          expect(album_comment).to_not have_link "album_comment#{album_comment2.id}_edit_form"
        end
      end
      context "削除のテスト" do
        it "成功する" do
          expect{
            click_link "album_comment#{album_comment.id}_delete"
          }.to change(user.album_comments, :count).by(-1)
          expect(all(".comment").count).to eq 1
        end
        it "表示されない" do
          expect(page).to_not have_link "alubum_comment#{album_comment2.id}_delete"
        end
      end
    end
    
  end
  
end
