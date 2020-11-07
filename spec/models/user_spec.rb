require 'rails_helper'

RSpec.describe User, type: :model do
  describe "バリデーション" do
    
    context "全ての値が存在する" do
      it "保存される" do
        user = User.create(
          user_name: "a" * 10,
          email: "1@1",
          password: "password"
        )
        expect(user).to be_valid  
      end
    end

    context "ユーザー名が11文字以上の場合" do
      it "保存されない" do
        user = User.create(
          user_name: "a" * 11,
          email: "1@1",
          password: "password"
        )
        expect(user).to be_invalid
      end
    end

  end
end
