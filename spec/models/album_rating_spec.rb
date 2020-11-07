require 'rails_helper'

RSpec.describe AlbumRating, type: :model do
  describe "バリデーション" do

    let(:user) { create(:user)}
    let(:test_album_id) { "123456789"}
    
    context "全ての値が存在する場合" do
      it "保存される" do
        album_rating = user.album_ratings.build(
          album_id: test_album_id,
          rate: 5
        )
        expect(album_rating).to be_valid  
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        album_rating = AlbumRating.create(
          album_id: test_album_id,
          rate: 5
        )
        expect(album_rating).to be_invalid 
      end
    end

    context "album_idが存在しない場合" do
      it "保存されない" do
        album_rating = user.album_ratings.build(
          rate: 5
        )
        expect(album_rating).to be_invalid  
      end
    end

    context "rateが存在しない場合" do
      it "保存されない" do
        album_rating = user.album_ratings.build(
          album_id: test_album_id
        )
        expect(album_rating).to be_invalid  
      end
    end

    context "rateの値が5よりも大きい場合" do
      it "保存されない" do
        album_rating = user.album_ratings.build(
          album_id: test_album_id,
          rate: 5.1
        )
        expect(album_rating).to be_invalid  
      end
    end
    
  end

  describe "アソシエーション" do
    
    context "Userモデル" do
      it "N:1になっている" do
        expect(AlbumRating.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
  end
  
end
