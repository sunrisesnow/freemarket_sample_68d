require 'rails_helper'
describe Address do
  describe '#create' do
    context 'can save' do
      it "必須項目が存在すれば登録できること" do
        address = build(:address)
        expect(address).to be_valid
      end

      it "電話番号(phone_number)         一桁目が０かつ10桁なら登録できること" do
        address = build(:address, phone_number: "0123456789")
        expect(address).to be_valid
      end

      it "電話番号(phone_number)         一桁目が０かつ11桁なら登録できること" do
        address = build(:address, phone_number: "01234567891")
        expect(address).to be_valid
      end
    end

    context 'can not save' do
      describe "本人氏名バリデーションチェック" do
        it "性（全角）（last_name）      存在しない場合登録できないこと" do
          address = build(:address, last_name: nil)
          address.valid?
          expect(address.errors[:last_name]).to include("を入力してください")
        end
    
        it "名（全角）（first_name）     存在しない場合登録できないこと" do
          address = build(:address, first_name: nil)
          address.valid?
          expect(address.errors[:first_name]).to include("を入力してください")
        end

        it "性（全角）（last_name）      全角以外な場合登録できないこと" do
          address = build(:address, last_name: "1-aA")
          address.valid?
          expect(address.errors[:last_name]).to include("は不正な値です")
        end
    
        it "名（全角）（first_name）     全角以外な場合登録できないこと" do
          address = build(:address, first_name: "1-aA")
          address.valid?
          expect(address.errors[:first_name]).to include("は不正な値です")
        end
    
        it "性（カナ）（last_name_kana） 存在しない場合登録できないこと" do
          address = build(:address, last_name_kana: nil)
          address.valid?
          expect(address.errors[:last_name_kana]).to include("を入力してください")
        end

        it "名（カナ）（first_name_kana）存在しない場合登録できないこと" do
          address = build(:address, first_name_kana: nil)
          address.valid?
          expect(address.errors[:first_name_kana]).to include("を入力してください")
        end

        it "性（カナ）（last_name_kana） カタカナ以外な場合登録できないこと" do
          address = build(:address, last_name_kana: "あ青-aA")
          address.valid?
          expect(address.errors[:last_name_kana]).to include("は不正な値です")
        end
    
        it "名（カナ）（first_name_kana）カタカナ以外な場合登録できないこと" do
          address = build(:address, first_name_kana: "あ青-aA")
          address.valid?
          expect(address.errors[:first_name_kana]).to include("は不正な値です")
        end
      end

      describe "郵便番号バリデーションチェック" do
        it "郵便番号(postal_code)        存在しない場合登録できないこと" do
          address = build(:address, postal_code: nil)
          address.valid?
          expect(address.errors[:postal_code]).to include("を入力してください")
        end

        it "郵便番号(postal_code)        数値以外を含む場合登録できないこと" do
          address = build(:address, postal_code: "あア青-aA")
          address.valid?
          expect(address.errors[:postal_code]).to include("は不正な値です")
        end

        it "郵便番号(postal_code)        8桁以上の場合登録できないこと" do
          address = build(:address, postal_code: "12345678")
          address.valid?
          expect(address.errors[:postal_code]).to include("は不正な値です")
        end

        it "郵便番号(postal_code)        6桁以下の場合登録できないこと" do
          address = build(:address, postal_code: "123456")
          address.valid?
          expect(address.errors[:postal_code]).to include("は不正な値です")
        end
      end

      describe "電話番号バリデーションチェック" do
        it "電話番号(phone_number)       数値以外を含む場合登録できないこと" do
          address = build(:address, phone_number: "あア青-aA")
          address.valid?
          expect(address.errors[:phone_number]).to include("は不正な値です")
        end

        it "電話番号(phone_number)       一桁目が0以外な場合登録できないこと" do
          address = build(:address, phone_number: "1123456789")
          address.valid?
          expect(address.errors[:phone_number]).to include("は不正な値です")
        end

        it "電話番号(phone_number)       9桁以下な場合登録できないこと" do
          address = build(:address, phone_number: "012345678")
          address.valid?
          expect(address.errors[:phone_number]).to include("は不正な値です")
        end

        it "電話番号(phone_number)       12桁以上な場合登録できないこと" do
          address = build(:address, phone_number: "012345678912")
          address.valid?
          expect(address.errors[:phone_number]).to include("は不正な値です")
        end
      end

      it "都道府県(prefectures)          存在しない場合登録できないこと" do
        address = build(:address, prefectures: nil)
        address.valid?
        expect(address.errors[:prefectures]).to include("を入力してください")
      end

      it "市区町村(municipality)         存在しない場合登録できないこと" do
        address = build(:address, municipality: nil)
        address.valid?
        expect(address.errors[:municipality]).to include("を入力してください")
      end

      it "番地(address)                  存在しない場合登録できないこと" do
        address = build(:address, address: nil)
        address.valid?
        expect(address.errors[:address]).to include("を入力してください")
      end
    end
  end
end