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

  describe "メソッドのテスト" do
    let(:user) { create(:user) }
    let(:user2) { create(:user2) }
    describe "follow" do
      it "他人をフォローできる" do
        expect{
          user.follow(user2)
        }.to change(user.relationships, :count).by(1)
      end
      it "自分をフォローできない" do
        expect{
          user.follow(user)
        }.to change(user.relationships, :count).by(0)
      end
    end
    describe "unfollow" do
      context "フォローしている場合" do
        let!(:relationship) { create(:relationship, user: user, follow: user2) }
        it "アンフォロー" do
          expect{
            user.unfollow(user2)
          }.to change(user.relationships, :count).by(-1)
        end
      end
      context "フォローしていない場合" do
        it "アンフォローしない" do
          expect{
            user.unfollow(user2)
          }.to change(user.relationships, :count).by(0)
        end
      end
    end
    describe "following?" do
      it "すでにフォローしている" do
        relationship = create(:relationship, user: user, follow: user2)
        expect(user.following?(user2)).to eq true
      end
      it "まだフォローしていない" do
        expect(user.following?(user2)).to eq false
      end
    end
    describe "create_notification_follow!" do
      it "Notificationが作成される" do
        expect{
          user2.create_notification_follow!(user)
        }.to change(user2.passive_notifications, :count).by(1)
      end
      it "Notiricationが作成されない" do
        notification = create(:follow_notification, visiter: user, visited: user2)
        expect{
          user2.create_notification_follow!(user)
        }.to change(user2.passive_notifications, :count).by(0)
      end
    end
    describe "create_song_impression" do
      it "PVデータ新規作成" do
        expect{
          user.create_song_impression("4VXIryQMWpIdGgYR4TrjT1")
        }.to change(SongImpression.all, :count).by(1)
      end
      it "PVデータの時間のみアップデート" do
        song_impression = create(:song_impression, user_id: user.id, updated_at: "Thu, 28 Jan 2021 00:00:00 JST +09:00")
        user.create_song_impression("4VXIryQMWpIdGgYR4TrjT1")
        expect(SongImpression.first.updated_at).to_not eq song_impression.updated_at 
      end
    end
    describe "guest" do
      it "ゲストユーザーを作成する" do
        expect{
          User.guest
        }.to change(User.all, :count).by(1)
      end
      it "ゲストユーザーを作成しない" do
        User.guest
        expect{
          User.guest
        }.to change(User.all, :count).by(0)
      end
    end
  end
  
end
