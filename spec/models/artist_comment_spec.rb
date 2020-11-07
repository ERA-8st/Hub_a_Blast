require 'rails_helper'

RSpec.describe ArtistComment, type: :model do
  describe "バリデーション" do
    
    let(:user) { create(:user) }
    let(:test_artist_id) { "123456789" }

    context "全ての値が存在する場合" do
      it "保存される" do
        artist_comment = user.artist_comments.build(
          artist_id: test_artist_id,
          comment: "test"
        )
        expect(artist_comment).to be_valid  
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        artist_comment = ArtistComment.create(
          artist_id: test_artist_id,
          comment: "test"
        )
        expect(artist_comment).to be_invalid  
      end
    end

    context "artist_idが存在しない場合" do
      it "保存されない" do
        artist_comment = user.artist_comments.build(
          comment: "test"
        )
        expect(artist_comment).to be_invalid  
      end
    end

    context "コメントが空の場合" do
      it "保存されない" do
        artist_comment = user.artist_comments.build(
          artist_id: test_artist_id
        )
        expect(artist_comment).to be_invalid  
      end
    end
  end
  
end
