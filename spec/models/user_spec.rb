require 'rails_helper'
describe User do
  describe '#create' do
    context 'can save' do
      it "必須項目が存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end
      
      it "パスワード（password）         7文字以上かつ128文字以下で半角英数字両方を含んでいれば登録できること" do
        user = build(:user, password: "abcd1234" * 16 , password_confirmation: "abcd1234" * 16)
        expect(user).to be_valid
      end

      it "メールアドレス（email）        半角英数字で構成されかつ@ドメインが存在している場合登録できること" do
        user = build(:user, email: "test_1@domain.jp")
        expect(user).to be_valid
      end
    end

    context 'can not save' do
      it "ニックネーム(nickname)         存在しない場合は登録できないこと" do
        user = build(:user, nickname: nil)
        user.valid?
        expect(user.errors[:nickname]).to include("を入力してください")
      end

      describe "メールアドレスバリデーションチェック" do
        it "メールアドレス（email）      存在しない場合は登録できないこと" do
          user = build(:user, email: nil)
          user.valid?
          expect(user.errors[:email]).to include("を入力してください")
        end

        it "メールアドレス（email）      重複したemailが存在する場合は登録できないこと" do
          user = create(:user, email: "test@mercari.com")
          another_user = build(:user, email: "test@mercari.com")
          another_user.valid?
          expect(another_user.errors[:email]).to include("はすでに存在します")
        end

        it "メールアドレス（email）      ドメインが存在しない場合登録できないこと" do
          user = build(:user, email: "test@domain.j")
          user.valid?
          expect(user.errors[:email]).to include("は不正な値です")
        end

        it "メールアドレス（email）      全角文字を含む場合登録できないこと" do
          user = build(:user, email: "test１あア青ー@domain.jp")
          user.valid?
          expect(user.errors[:email]).to include("は不正な値です")
        end
      end
      
      describe "パスワードバリデーションチェック" do
        it "パスワード（password）       存在しない場合登録できないこと" do
          user = build(:user, password: nil, password_confirmation: nil)
          user.valid?
          expect(user.errors[:password]).to include("を入力してください")
        end

        it "パスワード（password）       半角英数字両方を含んでいていも6文字以下の場合登録できないこと" do
          user = build(:user, password: "abc123", password_confirmation: "abc123")
          user.valid?
          expect(user.errors[:password]).to include("は7文字以上で入力してください")
        end

        it "パスワード（password）       半角英数字両方を含んでも129文字以上の場合登録できないこと" do
          user = build(:user, password: "a12" * 43, password_confirmation:  "a12" * 43)
          user.valid?
          expect(user.errors[:password]).to include("は128文字以内で入力してください")
        end

        it "パスワード（password）       半角英数字以外を含む場合登録できないこと" do
          user = build(:user, password: "１あアーabc1234", password_confirmation: "１あアーabc1234")
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end

        it "パスワード（password）       半角英字のみな場合登録できないこと" do
          user = build(:user, password: "a" * 7, password_confirmation: "a" * 7)
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end

        it "パスワード（password）       半角数字のみな場合登録できないこと" do
          user = build(:user, password: "1" * 7, password_confirmation: "1" * 7)
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end
      end

      describe "本人氏名バリデーションチェック" do
        it "姓（全角）（last_name）      存在しない場合登録できないこと" do
          user = build(:user, last_name: nil)
          user.valid?
          expect(user.errors[:last_name]).to include("を入力してください")
        end
    
        it "名（全角）（first_name）     存在しない場合登録できないこと" do
          user = build(:user, first_name: nil)
          user.valid?
          expect(user.errors[:first_name]).to include("を入力してください")
        end

        it "姓（全角）（last_name）      全角以外な場合登録できないこと" do
          user = build(:user, last_name: "1-aA")
          user.valid?
          expect(user.errors[:last_name]).to include("は不正な値です")
        end
    
        it "名（全角）（first_name）     全角以外な場合登録できないこと" do
          user = build(:user, first_name: "1-aA")
          user.valid?
          expect(user.errors[:first_name]).to include("は不正な値です")
        end
    
        it "姓（カナ）（last_name_kana） 存在しない場合登録できないこと" do
          user = build(:user, last_name_kana: nil)
          user.valid?
          expect(user.errors[:last_name_kana]).to include("を入力してください")
        end

        it "名（カナ）（first_name_kana）存在しない場合登録できないこと" do
          user = build(:user, first_name_kana: nil)
          user.valid?
          expect(user.errors[:first_name_kana]).to include("を入力してください")
        end

        it "姓（カナ）（last_name_kana） カタカナ以外な場合登録できないこと" do
          user = build(:user, last_name_kana: "あ青-aA")
          user.valid?
          expect(user.errors[:last_name_kana]).to include("は不正な値です")
        end
    
        it "名（カナ）（first_name_kana）カタカナ以外な場合登録できないこと" do
          user = build(:user, first_name_kana: "あ青-aA")
          user.valid?
          expect(user.errors[:first_name_kana]).to include("は不正な値です")
        end
      end

      it '生年月日(birthday)             が存在しない場合保存できないこと' do
        user = build(:user, birthday: nil)
        user.valid?
        expect(user.errors[:birthday]).to include("を入力してください")
      end
  
      # it "passwordが存在しても、password_confirmationがない場合は登録できないこと" do
      #   user = build(:user, password_confirmation: nil)
      #   user.valid?
      #   binding.pry
      #   expect(user.errors[:password_confirmation]).to include("")
      # end
    end
  end
end