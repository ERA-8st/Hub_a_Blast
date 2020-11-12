require 'rails_helper'

RSpec.describe User::RoomsController, type: :controller do

  let(:user1) { create(:user) } 
  let(:user2) { create(:user2) }
  let(:room) { create(:room) }

  describe "create" do
    
    # context "" do
    #   it "" do
    #     room_params = FactoryBot.attributes_for(:room)
    #     sign_in user1
    #     post :create
    #     expect(response).to change(Room.all :count).by(2)  
    #   end
    # end
    
  end
  

  describe "show" do
    
    context "Room及び適切なEntryが存在する場合" do
      it "遷移できる" do
        sign_in user1
        entry = user1.entries.create(
          room_id: room.id
        )
        get :show, params: { id: room.id, pair_user_id: user2.id }
        expect(response).to be_success  
      end
    end

    context "適切なEntryが存在しない場合" do
      it "直前の画面に遷移する" do
        sign_in user1
        entry = user2.entries.create(
          room_id: room.id
        )
        get :show, params: { id: room.id, pair_user_id: user2.id }
        expect(response).to redirect_to root_path
      end
    end
    
  end
  
end
