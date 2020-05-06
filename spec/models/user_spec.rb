require 'rails_helper'
describe User do
  describe '#create' do

    context 'can save' do
      it "必須項目が存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end
      
      it "passwordが7文字以上であれば登録できること" do
        user = build(:user, password: "1234567", password_confirmation: "1234567")
        expect(user).to be_valid
      end
    end

    context 'can not save' do
      it "ニックネーム(nickname)がない場合は登録できないこと" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end
  
      it "emailがない場合は登録できないこと" do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email]).to include("を入力してください")
      end
  
      it "passwordがない場合は登録できないこと" do
        user = build(:user, password: nil, password_confirmation: nil)
        user.valid?
        expect(user.errors[:password]).to include("を入力してください")
      end
  
      # it "passwordが存在しても、password_confirmationがない場合は登録できないこと" do
      #   user = build(:user, password_confirmation: nil)
      #   user.valid?
      #   binding.pry
      #   expect(user.errors[:password_confirmation]).to include("")
      # end
    
      it "重複したemailが存在する場合は登録できないこと" do
        user = create(:user, email: "test@mercari.com")
        another_user = build(:user, email: "test@mercari.com")
        another_user.valid?
        expect(another_user.errors[:email]).to include("はすでに存在します")
      end
  
      it "passwordが6文字以下であれば登録できないこと" do
        user = build(:user, password: "123456", password_confirmation: "123456")
        user.valid?
        expect(user.errors[:password]).to include("は7文字以上で入力してください")
      end
    end

  end

end