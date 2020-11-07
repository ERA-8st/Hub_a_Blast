require 'rails_helper'

RSpec.describe SongImpression, type: :model do
  describe "バリデーション" do

    let(:user) { create(:user) }
    let(:test_song_id) { "123456789" }

    context "全ての値が存在する場合" do
      it "保存される" do
        song_impression = SongImpression.create(
          user_id: user.id,
          song_id: test_song_id
        )
        expect(song_impression).to be_valid  
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        song_impression = SongImpression.create(
          song_id: test_song_id
        ) 
        expect(song_impression).to be_invalid  
      end
    end

    context "song_idが存在しない場合" do
      it "保存されない" do
        song_impression = SongImpression.create(
          user_id: user.id
        )
        expect(song_impression).to be_invalid  
      end
    end
    
  end
end
