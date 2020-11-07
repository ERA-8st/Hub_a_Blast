require 'rails_helper'

RSpec.describe AlbumComment, type: :model do
  describe "バリデーション" do
    
    let(:user) { create(:user) }
    let(:test_album_id) { "123456789" }

    context "全ての値が存在する場合" do
      it "保存される" do
        album_comment = user.album_comments.build(
          album_id: test_album_id,
          comment: "test"
        )
        expect(album_comment).to be_valid  
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        album_comment = AlbumComment.create(
          album_id: test_album_id,
          comment: "test"
        )
        expect(album_comment).to be_invalid  
      end
    end

    context "album_idが存在しない場合" do
      it "保存されない" do
        album_comment = user.album_comments.build(
          comment: "test"
        )
        expect(album_comment).to be_invalid  
      end
    end
    
    context "コメントが空の場合" do
      it "保存されない" do
        album_comment = user.album_comments.build(
          album_id: test_album_id
        )
        expect(album_comment).to be_invalid  
      end
    end
    
  end
end
