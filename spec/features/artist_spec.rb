require 'rails_helper'

describe "アーティストのテスト" do
  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  let!(:artist_comment) { create(:artist_comment, user: user) }
  let!(:artist_comment2) { create(:artist_comment2, user: user2) }
  before do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    # visit user_spotify_artist_show_path("???")
  end
  describe "アーティスト詳細のテスト" do
    context "タイトルのテスト" do
      let(:title) { find(".head_title") }
      it "正しく表示される" do
        # expect(title).to have_content "???"
      end
    end
    context "詳細のテスト" do
      let(:artist_show) { find(".artist-show-left") }
      it "各種情報が正しく表示される" do
        # expect(artist_show).to have_selector "img"
        # expect(artist_show).to have_content "artist_name"
        expect(artist_show).to have_selector ".fb-share-button"
        expect(artist_show).to have_selector(".line-it-button", visible: false)
        expect(artist_show).to have_selector ".twitter-share-button"
      end
    end
    context "コメントのテスト" do
      let(:artist_show_comments) { find(".artist-show-right") }
      context "表示のテスト" do
        it "コメントが全て表示される" do
          expect(all(".comment").count).to eq 2
          expect(page).to have_content artist_comment.comment
          expect(page).to have_content artist_comment2.comment
        end
        it "コメント数が表示される" do
          expect(page).to have_content "2コメント"
        end
      end
      context "表示のテスト" do
        it "成功する" do
          expect{
            fill_in "artist_comment_comment", with: "test"
            click_button "送信する"
          }.to change(user.artist_comment, :count).by(1)
        end
        it "失敗する" do
          expect{
            fill_in "artist_comment_comment", with: ""
            click_button "送信する"
            expect(artist_show_comments).to have_content "コメントを入力してください"
          }.to change(user.artist_comments, :count).by(0)
        end
        it "フォームが表示されない" do
          expect(artist_show_comments).to have_selector "textarea#artist_comment_comment"
          expect(artist_show_comments).to have_selector "input[value='送信する']"
          click_link "LOG_OUT"
          # visit user_spotify_artist_show_path("???")
          expect(artist_show_comments).to_not have_selector "textarea#artist_comment_comment"
          expect(artist_show_comments).to_not have_selector "input[value='送信する']"
        end
      end
      context "更新のテスト" do
        before do
          click_link "artist_comment#{artist_comment.id}_edit_form"
        end
        it "成功する" do
          fill_in "artist_comment#{artist_comment.id}_edit", with: "changed_artist_comment"
          click_button "更新する"
          expect(artist_comment.reload.comment).to eq "changed_artist_comment"
        end
        it "失敗する" do
          fill_in "artist_comment#{artist_comment.id}_edit_form", with: ""
          click_button "更新する"
          expect(artist_show_comments).to have_content "コメントを入力してください"
        end
        it "取り消せる" do
          fill_in "artist_comment#{artist_comment.id}_edit_form", with: "changed_artist_comment"
          click_link "取り消し"
          expect(page).to_not have_selector "textarea#artist_comment#{artist_comment.id}_edit_form"
          expect(artist_comment.reload.comment).to eq "artist_comment_test"
        end
        it "表示されない" do
          # visit user_spotify_artist_show_path("???")
          expect(artist_comment).to_not have_link "artist_comment#{artist_comment2.id}_edit_form"
        end
      end
      context "削除のテスト" do
        it "成功する" do
          expect{
            click_link "artist_comment#{artist_comment.id}_delete"
          }.to change(user.artist_comment, :count).by(1)
          expect(all(".comment").count).to eq 1
        end
        it "表示されない" do
          expect(page).to_not have_link "artist_comment#{artist_comment2.id}_delete"
        end
      end
      
    end
    
  end
  
end
