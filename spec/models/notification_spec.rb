require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe "バリデーション" do

    let(:user1) { create(:user)}
    let(:user2) { create(:user2)}

    context "全ての値が存在する場合" do
      it "保存される" do
        notification = Notification.create(
          visiter_id: user1.id,
          visited_id: user2.id,
          action: "follow"
        )
        expect(notification).to be_valid  
      end
    end 

    context "visiter_idが存在しない場合" do
      it "保存されない" do
        notification = Notification.create(
          visited_id: user2.id,
          action: "follow"
        )
        expect(notification).to be_invalid  
      end
    end

    context "visited_idが存在しない場合" do
      it "保存されない" do
        notification = Notification.create(
          visiter_id: user1.id,
          action: "follow"
        )
        expect(notification).to be_invalid  
      end
    end
    
    context "actionが存在しない場合" do
      it "保存されない" do
        notification = Notification.create(
          visiter_id: user1.id,
          visited_id: user2.id
        )
        expect(notification).to be_invalid  
      end
    end

    describe "actionがメッセージの場合" do

      let(:room) { create(:room) }

      context "全ての値が存在する場合" do
        it "保存される" do
          notification = Notification.create(
            visiter_id: user1.id,
            visited_id: user2.id,
            action: "message",
            message: "test",
            room_id: room.id
          )
          expect(notification).to be_valid  
        end
      end

      context "メッセージが空の場合" do
        it "保存されない" do
          notification = Notification.create(
            visiter_id: user1.id,
            visited_id: user2.id,
            action: "message",
            room_id: room.id
          )
          expect(notification).to be_invalid  
        end
      end

      context "room_idが空の場合" do
        it "保存されない" do
          notification = Notification.create(
            visiter_id: user1.id,
            visited_id: user2.id,
            action: "message",
            message: "test"
          )
          expect(notification).to be_invalid  
        end
      end
      
      
    end
  end
end
