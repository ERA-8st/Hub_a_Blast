require 'rails_helper'

RSpec.describe SongRating, type: :model do

  describe "バリデーション" do
    
    let(:user) { create(:user) }
    let(:test_song_id) { "123456789"}

    context "全ての値が存在する場合" do
      it "保存される" do
        song_rating = user.song_ratings.build(
          song_id: test_song_id,
          rate: 5
        )
        expect(song_rating).to be_valid  
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        song_rating = SongRating.create(
          song_id: test_song_id,
          rate: 5
        )
        expect(song_rating).to be_invalid  
      end
    end

    context "song_idが存在しない場合" do
      it "保存されない" do
        song_rating = user.song_ratings.build(
          rate: 5
        )
        expect(song_rating).to be_invalid  
      end
    end
    
    context "rateが存在しない場合" do
      it "保存されない" do
        song_rating = user.song_ratings.build(
          song_id: test_song_id
        )
        expect(song_rating).to be_invalid
      end
    end
    
    context "rateの値が5よりも大きい場合" do
      it "保存されない" do
        song_rating = user.song_ratings.build(
          song_id: test_song_id,
          rate: 5.1
        )
        expect(song_rating).to be_invalid  
      end
    end
    
  end

  describe "アソシエーション" do
    
    context "Userモデル" do
      it "N:1になっている" do
        expect(SongRating.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
  end
  
end
