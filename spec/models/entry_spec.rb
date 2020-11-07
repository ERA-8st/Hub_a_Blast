require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe "バリデーション" do

    let(:user) { create(:user) }
    let(:room) { create(:room) }
    
    context "全ての値が存在する場合" do
      it "保存される" do
        entry = user.entries.build(
          room_id: room.id
        )
        expect(entry).to be_valid  
      end
    end
    
    context "user_idが存在しない場合" do
      it "保存されない" do
        entry = room.entries.build
        expect(entry).to be_invalid  
      end
    end
    
    context "room_idが存在しない場合" do
      it "保存されない" do
        entry = user.entries.build
        expect(entry).to be_invalid  
      end
    end

    context "user_idとroom_idの組み合わせがすでに存在している場合" do
      it "保存されない" do
        entry1 = user.entries.create(
          room_id: room.id
        )
        entry2 = user.entries.create(
          room_id: room.id
        )
        expect(entry2).to be_invalid  
      end
    end
    
  end
end
