require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    
    context "全ての値が存在する" do
      it "保存される" do
        user = User.create(
          user_name: "a" * 10,
          email: "1@1",
          password: "password"
        )
        expect(user).to be_valid  
      end
    end

    context "ユーザー名が11文字以上の場合" do
      it "保存されない" do
        user = User.create(
          user_name: "a" * 11,
          email: "1@1",
          password: "password"
        )
        expect(user).to be_invalid
      end
    end

  end

  describe "アソシエーション" do

    context "ArtistCommentモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:artist_comments).macro).to eq :has_many 
      end
    end

    context "AalbumCommentモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:album_comments).macro).to eq :has_many  
      end
    end

    context "AlbumRatingモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:album_ratings).macro).to eq :has_many  
      end
    end

    context "SongCommentモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:song_comments).macro).to eq :has_many  
      end
    end
    
    context "SongRatingモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:song_ratings).macro).to eq :has_many
      end
    end
    
    context "SongFavoriteモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:song_favorites).macro).to eq :has_many
      end
    end
    
    context "Relationshipモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:relationships).macro).to eq :has_many
      end
    end

    context "Relationshipモデル(followings)" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:followings).macro).to eq :has_many
      end
    end

    context "Relationshipモデル(reverse_of_relationships)" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:reverse_of_relationships).macro).to eq :has_many
      end
    end

    context "Relationshipモデル(followers)" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:followers).macro).to eq :has_many
      end
    end

    context "Messageモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context "Entryモデル" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context "Notificationモデル(active_notifications)" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:active_notifications).macro).to eq :has_many
      end
    end

    context "Notificationモデル(passive_notifications)" do
      it "1:Nになっている" do
        expect(User.reflect_on_association(:passive_notifications).macro).to eq :has_many
      end
    end
  end
  
end
