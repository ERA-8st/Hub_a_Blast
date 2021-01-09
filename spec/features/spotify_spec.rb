require 'rails_helper'

describe "spotify" do
  let(:user) { create(:user) }
  before do
    visit new_user_session_path
    fill_in "user_email", with: user.email
    fill_in "user_password", with: user.password
    click_button "Log in"
  end
  describe "検索機能" do
    before do
      visit root_path
      fill_in "search", with: "a"
      click_button "検索"
    end
    context "フォームに内容を入力して検索" do
      it "アーティストの検索結果が表示される" do
        expect(page).to have_link "", id: "artist_1"
      end
      it "アルバムの検索結果が表示される" do
        expect(page).to have_link "", id: "album_1"
      end
      it "曲の検索結果が表示される" do
        expect(page).to have_link "", id: "song_1"
      end
      context "「さらに表示する」をクリックする" do
        it "アーティストの検索結果が最大８件追加表示される" do
          click_link "more_artists"
          expect(page).to have_link "", id: "artist_12"
        end
        it "アルバムの検索結果が最大８件追加表示される" do
          click_link "more_albums"
          expect(page).to have_link "", id: "album_12"
        end
        it "曲の検索結果が最大８件追加表示される" do
          click_link "more_songs"
          expect(page).to have_link "", id: "song_12"
        end
      end
    end
  end

  describe "TOP" do
    let(:top) { find(".top") }
    describe "ヘッダーのテスト" do
      let(:song_header) { (find(".song_header")) }
      context "ログインしている場合" do
        it "正しく表示される" do
          expect(song_header.all("a").count).to eq 5
          expect(song_header).to have_link "Top", href: user_home_top_path
          expect(song_header).to have_link "New Releases", href: user_spotify_new_releases_path
          expect(song_header).to have_link "Charged Up", href: user_spotify_charged_ups_path
          expect(song_header).to have_link "Top Impressions", href: user_song_impressions_path
          expect(song_header).to have_link "Browsing History", href: user_browsing_history_index_path
        end
      end
      context "ログインしていない場合" do
        it "正しく表示される" do
          click_link "LOG_OUT"
          expect(song_header.all("a").count).to eq 4
          expect(song_header).to have_link "Top", href: user_home_top_path
          expect(song_header).to have_link "New Releases", href: user_spotify_new_releases_path
          expect(song_header).to have_link "Charged Up", href: user_spotify_charged_ups_path
          expect(song_header).to have_link "Top Impressions", href: user_song_impressions_path
        end
      end
    end
    context "ログインしている場合" do
      it "正しく表示される" do
        expect(top.all(".row").count).to eq 4
        expect(top).to have_link "New Releases", href: user_spotify_new_releases_path
        expect(top).to have_link "Charged Up", href: user_spotify_charged_ups_path
        expect(top).to have_content "Latest Your comment"
      end
    end
    context "ログインしていない場合" do
      it "正しく表示される" do
        click_link "LOG_OUT"
        expect(top.all(".row").count).to eq 3
        expect(top).to have_link "New Releases", href: user_spotify_new_releases_path
        expect(top).to have_link "Charged Up", href: user_spotify_charged_ups_path
      end
    end
  end

  describe "new_release" do
    before do
      visit user_spotify_new_releases_path
    end
    it "正しく表示される" do
      expect(page).to have_selector "h4", text: "New Releases"
      expect(page).to have_selector "select", id: "country"
      expect(page).to have_selector(".new_releases")
    end
    it "国別検索ができる" do
      find("option[value='JP']").select_option
      find(".select_country").click_button("検索")
      expect(page).to have_selector "h4", text: "New Releases(JP)"
    end
  end

  describe "Charged Up" do
    let!(:song_comment1) { create(:song_comment, user: user) }
    let!(:song_comment2) { create(:song_comment2, user: user) }
    before do
      visit user_spotify_charged_ups_path
    end
    it "正しく表示される" do
      expect(page).to have_selector "h3", text: "Charged Up"
      expect(page).to have_selector "select", id: "times"
      expect(page).to have_selector ".charged_up_table"
      expect(find(".charged_up_table")).to have_content "2Comments"  
    end
    it "期間ごとに絞り込みができる" do
      find("option[value='今日']").select_option
      find(".charged_up_search").click_button("検索")
      expect(page).to  have_content "Charged Up(Today)"

      find("option[value='１週間']").select_option
      find(".charged_up_search").click_button("検索")
      expect(page).to  have_content "Charged Up(Week)"

      find("option[value='一ヶ月']").select_option
      find(".charged_up_search").click_button("検索")
      expect(page).to  have_content "Charged Up(Month)"

      find("option[value='指定無し']").select_option
      find(".charged_up_search").click_button("検索")
      expect(page).to  have_content "Charged Up"
    end
  end
  
end


