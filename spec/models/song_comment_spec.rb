require 'rails_helper'

RSpec.describe SongComment, type: :model do

  describe "バリデーション" do
    
    let(:user){ create(:user) }
    let(:test_song_id){ "123456789" }
    
    context "全ての値が存在する場合" do
      it "保存される" do
        song_comment = user.song_comments.build(
          song_id: test_song_id ,
          comment: "test"
        )
        expect(song_comment).to be_valid
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        song_comment = SongComment.create(
          song_id: test_song_id ,
          comment: "test"
        )
        expect(song_comment).to be_invalid
      end
    end

    context "song_idが存在しない場合" do
      it "保存されない" do
        song_comment = user.song_comments.build(
          comment: "test"
        )
        expect(song_comment).to be_invalid
      end
    end

    context "コメントが空の場合" do
      it "保存されない" do
        song_comment = user.song_comments.build(
          song_id: test_song_id,
        )
        expect(song_comment).to be_invalid
      end
    end

  end

  describe "アソシエーション" do
    
    context "Userモデル" do
      it "N:1になっている" do
        expect(SongComment.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    
  end
  
end
