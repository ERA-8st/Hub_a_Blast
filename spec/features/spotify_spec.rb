require 'rails_helper'

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
