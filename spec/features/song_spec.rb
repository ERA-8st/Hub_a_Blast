require 'rails_helper'

describe "曲のテスト" do
  let(:user) { create(:user) }
  let(:user2) { create(:user2) }
  let!(:song_comment) { create(:song_comment, user: user) }
  let!(:song_comment2) { create(:song_comment2, user: user2) } 
  before do
    visit new_user_session_path
    fill_in "user_email",	with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
    visit user_spotify_song_show_path("4VXIryQMWpIdGgYR4TrjT1")
  end
  describe "曲詳細のテスト" do
    # context "タイトルのテスト" do
    #   let(:title) { find(".head_title") }
    #   it "アーティストのリンクが表示され正しく機能する" do
    #     expect(title).to have_link "Juice WRLD"
    #     title.click_link "Juice WRLD"
    #     expect(current_path).to eq user_spotify_artist_show_path("4MCBfE4596Uoi2O4DtmEMz")
    #   end
    #   it "アルバムのリンクが表示され正しく機能する" do
    #     expect(title).to have_link "Goodbye & Good Riddance"
    #     title.click_link "Goodbye & Good Riddance"
    #     expect(current_path).to eq user_spotify_album_show_path("6tkjU4Umpo79wwkgPMV3nZ")
    #   end
    #   it "曲名が表示される" do
    #     expect(title).to have_content "All Girls Are The Same"
    #   end
    # end
    # context "詳細のテスト" do
    #   let(:song_show) { find(".song-show-left")}
    #   it "アルバムの画像が表示される" do
    #     expect(song_show).to have_selector "img[src$='https://i.scdn.co/image/ab67616d00001e02f7db43292a6a99b21b51d5b4']"
    #   end
    #   it "曲名が表示される" do
    #     expect(song_show).to have_content "All Girls Are The Same"
    #   end
    #   it "プレビューURLが表示される" do
    #     expect(song_show).to have_link "Preview", href: "/user/spotify/song_show/4VXIryQMWpIdGgYR4TrjT1"
    #   end
    #   it "外部リンクが表示される" do
    #     expect(song_show).to have_link "Listen on Spotify", href: "https://open.spotify.com/track/4VXIryQMWpIdGgYR4TrjT1"
    #   end
    #   it "Facebookシェアリンクが表示される" do
    #     expect(song_show).to have_selector ".fb-share-button"
    #   end
    #   it "LINEシェアリンクが表示される" do
    #     expect(song_show).to have_selector(".line-it-button", visible: false)
    #   end
    #   it "Twitterシェアリンクが表示される" do
    #     expect(song_show).to have_selector ".twitter-share-button"
    #   end
    #   it "favoriteリンクが表示される" do
    #     expect(song_show).to have_link "", href: user_song_favorites_path(song_id: "4VXIryQMWpIdGgYR4TrjT1")
    #   end
    #   it "評価機能が表示される" do
    #     expect(song_show).to have_selector ".song_rating"
    #   end
    #   context "ログインしていない場合" do
    #     before do
    #       click_link "LOG_OUT"
    #       visit user_spotify_song_show_path("4VXIryQMWpIdGgYR4TrjT1")
    #     end
    #     it "favoriteリンクが表示されない" do
    #       expect(song_show).to_not have_link "", href: user_song_favorites_path(song_id: "4VXIryQMWpIdGgYR4TrjT1")
    #     end
    #     it "評価機能が表示されない" do
    #       expect(song_show).to_not have_selector ".song_rating"
    #     end
    #   end
    # end
    # context "コメントのテスト" do
    #   let(:song_show_comments) { find(".song-show-right") }
    #   context "表示のテスト" do
    #     it "コメントが全て表示される" do
    #       expect(all(".comment").count).to eq 2
    #       expect(page).to have_content song_comment.comment
    #       expect(page).to have_content song_comment2.comment
    #     end
    #     it "コメント数が表示される" do
    #       expect(page).to have_content "2コメント"
    #     end
    #   end
    #   context "投稿のテスト" do
    #     it "成功する" do
    #       expect{
    #         fill_in "song_comment_comment", with: "test"
    #         click_button "送信する"
    #       }.to change(user.song_comments, :count).by(1)
    #     end
    #     it "失敗する" do
    #       expect{
    #         fill_in "song_comment_comment", with: ""
    #         click_button "送信する"
    #         expect(song_show_comments).to have_content "コメントを入力してください"
    #       }.to change(user.song_comments, :count).by(0)
    #     end
    #     it "フォームが表示されない" do
    #       click_link "LOG_OUT"
    #       visit user_spotify_song_show_path("4VXIryQMWpIdGgYR4TrjT1")
    #       expect(song_show_comments).to_not have_selector "textarea#song_comment_comment"
    #       expect(song_show_comments).to_not have_selector "input[value='送信する']"
    #     end
    #   end
    #   context "更新のテスト" do
    #     before do
    #       click_link "song_comment#{song_comment.id}_edit"
    #     end
    #     it "成功する" do
    #       fill_in "song_comment#{song_comment.id}_edit_form", with: "changed_song_comment"
    #       click_button "更新する"
    #       expect(song_comment.reload.comment).to eq "changed_song_comment"
    #     end
    #     it "失敗する" do
    #       fill_in "song_comment#{song_comment.id}_edit_form", with: ""
    #       click_button "更新する"
    #       expect(song_show_comments).to have_content "コメントを入力してください"
    #     end
    #     it "取り消せる" do
    #       fill_in "song_comment#{song_comment.id}_edit_form", with: "changed_song_comment"
    #       click_link "取り消し"
    #       expect(page).to_not have_selector "textarea#song_comment#{song_comment.id}_edit_form"
    #       expect(song_comment.reload.comment).to eq "song_comment_test"
    #     end
    #     it "表示されない" do
    #       visit user_spotify_song_show_path("4VXIryQMWpIdGgYR4TrjT1")
    #       expect(song_comment).to_not have_link "song_comment#{song_comment2.id}_edit"
    #     end
    #   end
    #   context "削除のテスト" do
    #     it "成功する" do
    #       expect{
    #         click_link "song_comment#{song_comment.id}_delete"
    #       }.to change(user.song_comments, :count).by(-1)
    #       expect(all(".comment").count).to eq 1
    #     end
    #     it "表示されない" do
    #       expect(page).to_not have_link "song_comment#{song_comment2.id}_delete"
    #     end
    #   end
    # end
    # context "ブックマークのテスト" do
    #   it "ブックマークのリンクが正しく表示される" do
    #     expect(page).to have_link "", href: user_song_favorites_path(song_id: "4VXIryQMWpIdGgYR4TrjT1")
    #     expect(find(".song_favorite")).to have_content "0"
    #     song_favorite = create(:song_favorite, user: user)
    #     visit current_path
    #     expect(page).to have_link "", href: user_song_favorite_path(song_favorite, song_id: "4VXIryQMWpIdGgYR4TrjT1")
    #     expect(find(".song_favorite")).to have_content "1"
    #   end
    # end
    # context "評価機能のテスト" do
    #   it "評価機能のリンクが正しく表示される" do
        
    #   end
    # end
  end
end

