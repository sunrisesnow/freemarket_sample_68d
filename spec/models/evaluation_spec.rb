require 'rails_helper'

describe Evaluation do
  describe "#create" do
    let(:user){create(:user)}
    let(:another_user){create(:user)}
    context "can save" do
      it '必須項目が存在していれば登録できること' do
        evaluation = build(:evaluation, user_id: user.id, saler_id: another_user.id, buyer_id: user.id)
        expect(evaluation).to be_valid
      end
      it 'コメント（comment）               存在せずとも登録できること' do
        evaluation = build(:evaluation, comment: nil ,user_id: user.id, saler_id: another_user.id, buyer_id: user.id)
        expect(evaluation).to be_valid
      end
    end
    context "can not save" do
      it '評価（evaluation）                存在しない場合登録できないこと' do
        evaluation = build(:evaluation, evaluation: nil, user_id: user.id, saler_id: another_user.id, buyer_id: user.id)
        evaluation.valid?
        expect(evaluation.errors[:evaluation]).to include("を入力してください")
      end
      it '評価されたユーザー（user_id）     存在しない場合登録できないこと' do
        evaluation = build(:evaluation, user_id: nil, saler_id: another_user.id, buyer_id: user.id)
        evaluation.valid?
        expect(evaluation.errors[:user_id]).to include("を入力してください")
      end
      it '評価された取引の出品者（saler_id）存在しない場合登録できないこと' do
        evaluation = build(:evaluation, user_id: user.id, saler_id: nil, buyer_id: user.id)
        evaluation.valid?
        expect(evaluation.errors[:saler_id]).to include("を入力してください")
      end
      it '評価された取引の購入者（buyer_id）存在しない場合登録できないこと' do
        evaluation = build(:evaluation, user_id: user.id, saler_id: another_user.id, buyer_id: nil)
        evaluation.valid?
        expect(evaluation.errors[:buyer_id]).to include("を入力してください")
      end
    end
  end
end