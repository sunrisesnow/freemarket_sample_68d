require 'rails_helper'

describe Item do
  describe '#create' do

    context 'can save' do
      it "画像(image)が存在し、その他の必須項目が存在すれば登録できること" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "画像(image)が複数枚存在し、その他の必須項目が存在すれば登録できること" do
        item = build(:item_has_many_images)
        expect(item).to be_valid
      end

      it "販売価格(price)が300以上であれば登録できること" do
        item = build(:item, price: "300")
        expect(item).to be_valid
      end

      it "販売価格(price)が10,000,000未満であれば登録できること" do
        item = build(:item, price: "9999999")
        expect(item).to be_valid
      end

    end

    context 'can not save' do
      it "画像(image)がない場合は登録できないこと" do
        item = build(:item_no_images)
        item.valid?
        expect(item.errors[:images]).to include("を入力してください")
      end

      it "商品名(name)がない場合は登録できないこと" do
        item = build(:item, name: nil)
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "商品の説明(explanation)がない場合は登録できないこと" do
        item = build(:item, explanation: nil)
        item.valid?
        expect(item.errors[:explanation]).to include("を入力してください")
      end

      it "商品のカテゴリー(category_id)がない場合は登録できないこと" do
        item = build(:item_no_category)
        item.valid?
        expect(item.errors[:category]).to include("を入力してください")
      end

      it "商品の状態(status_id)がない場合は登録できないこと" do
        item = build(:item, status_id: nil)
        item.valid?
        expect(item.errors[:status_id]).to include("を入力してください")
      end

      it "配送料の負担(delivery_charge_flag)がない場合は登録できないこと" do
        item = build(:item, delivery_charge_flag: nil)
        item.valid?
        expect(item.errors[:delivery_charge_flag]).to include("を入力してください")
      end

      it "発送元の地域(prefecture_id)がない場合は登録できないこと" do
        item = build(:item, prefecture_id: nil)
        item.valid?
        expect(item.errors[:prefecture_id]).to include("を入力してください")
      end

      it "発送までの日数(delivery_date_id)がない場合は登録できないこと" do
        item = build(:item, delivery_date_id: nil)
        item.valid?
        expect(item.errors[:delivery_date_id]).to include("を入力してください")
      end

      it "販売価格(price)がない場合は登録できないこと" do
        item = build(:item, price: nil)
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end

      it "販売価格(price)が300未満の場合は登録できないこと" do
        item = build(:item, price: "299")
        item.valid?
        expect(item.errors[:price]).to include("は300以上の値にしてください")
      end

      it "販売価格(price)が10,000,000以上の場合は登録できないこと" do
        item = build(:item, price: "10000000")
        item.valid?
        expect(item.errors[:price]).to include("は10000000より小さい値にしてください")
      end

    end
  end
end