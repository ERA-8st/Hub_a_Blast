require 'rails_helper'

RSpec.describe SongFavorite, type: :model do
  describe "バリデーション" do
    
    let(:user) { create(:user) }
    let(:test_song_id) { "123456789" }

    context "全ての値が存在する場合" do
      it "保存される" do
        song_favorite = user.song_favorites.build(
          song_id: test_song_id
        )
        expect(song_favorite).to be_valid
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        song_favorite = SongFavorite.create(
          song_id: test_song_id
        )
        expect(song_favorite).to be_invalid
      end
    end

    context "song_idが存在しない場合" do
      it "保存されない" do
        song_favorite = user.song_favorites.build
        expect(song_favorite).to be_invalid
      end
    end

    context "user_idとsong_idの組み合わせがすでに存在する場合" do
      it "保存されない" do
        song_favorite1 = user.song_favorites.create(
          song_id: test_song_id
        )
        song_favorite2 = user.song_favorites.create(
          song_id: test_song_id
        )
        expect(song_favorite2).to be_invalid  
      end
    end

  end
end
