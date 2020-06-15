require 'rails_helper'

describe Card do
  describe "#create" do
    let(:user) {create(:user)}
    context "can save" do
      it "必須項目が存在すれば登録できること" do
        card = build(:card, user_id: user.id)
        expect(card).to be_valid
      end
    end
    context "can not save" do
      it 'トークンid（payjp_id）存在しない場合登録できないこと' do
        card = build(:card, payjp_id: nil, user_id: user.id)
        card.valid?
        expect(card.errors[:payjp_id]).to include("を入力してください")
      end
      it "外部キー（user_id）存在しない場合登録できないこと" do
        card = build(:card, user_id: nil)
        card.valid?
        expect(card.errors[:user_id]).to include("を入力してください")
      end
    end
  end
end
