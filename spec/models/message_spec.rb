require 'rails_helper'

RSpec.describe Message, type: :model do

  describe "バリデーション" do

    let(:user) { create(:user) }
    let(:room) { create(:room) }

    context "全ての値が存在する場合" do
      it "保存される" do
        message = user.messages.build(
          room_id: room.id,
          message: "test"
        )
        expect(message).to be_valid
      end
    end

    context "user_idが存在しない場合" do
      it "保存されない" do
        message = Message.create(
          room_id: room.id,
          message: "test"
        )
        expect(message).to be_invalid
      end
    end

    context "room_idが存在しない場合" do
      it "保存されない" do
        message = user.messages.build(
          message: "test"
        )
        expect(message).to be_invalid
      end
    end

    context "メッセージ内容が空の場合" do
      it "保存されない" do
        message = user.messages.build(
          room_id: room.id
        )
        expect(message).to be_invalid
      end
    end

  end

  describe "アソシエーション" do
    
    context "Userモデル" do
      it "N:1になっている" do
        expect(Message.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Roomモデル" do
      it "N:1になっている" do
        expect(Message.reflect_on_association(:room).macro).to eq :belongs_to
      end
    end
    
  end
  
end
