require 'rails_helper'

RSpec.describe Relationship, type: :model do

  describe "バリデーション" do

    let(:user1) { create(:user)}
    let(:user2) { create(:user2)}

    context "全ての値が存在する場合" do
      it "保存される" do
        relationship = user1.relationships.build(
          follow_id: user2.id
        )
        expect(relationship).to be_valid  
      end
    end
    
    context "user_idが存在しない場合" do
      it "保存されない" do
        relationship = Relationship.create(
          follow_id: user2.id
        )
        expect(relationship).to be_invalid  
      end
    end

    context "follow_idが存在しない場合" do
      it "保存されない" do
        relationship = user1.relationships.build
        expect(relationship).to be_invalid  
      end
    end
    
  end

  describe "アソシエーション" do
    
    context "Userモデル" do
      it "N:1になっている" do
        expect(Relationship.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end

    context "Userモデル(follow)" do
      it "N:1になっている" do
        expect(Relationship.reflect_on_association(:follow).macro).to eq :belongs_to
      end
    end
    
  end
  
end
