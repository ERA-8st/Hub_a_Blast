require 'rails_helper'

RSpec.describe Room, type: :model do

  describe "アソシエーション" do
    
    context "Messageモデル" do
      it "1:Nになっている" do
        expect(Room.reflect_on_association(:messages).macro).to eq :has_many
      end
    end

    context "Entryモデル" do
      it "1:Nになっている" do
        expect(Room.reflect_on_association(:entries).macro).to eq :has_many
      end
    end
    
  end
  
end
