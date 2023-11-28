require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context 'ユーザー登録できる時' do
      it 'すべての記入事項が正しく設定されていれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context 'ユーザー登録できない時' do
      it 'ニックネームが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('ニックネームを入力してください')
      end
      it 'メールアドレスが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールを入力してください')
      end
      it '重複したメールアドレスが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Eメールはすでに存在します')
      end
      it 'メールアドレスは@を含まないと登録できない' do
        @user.email = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('Eメールは不正な値です')
      end
      it 'パスワードが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードを入力してください')
      end
      it 'パスワードが５文字以下だと登録できない' do
        @user.password = 'a1111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは6文字以上で入力してください')
      end
      it 'パスワードに全角文字が含まれていると登録できない' do
        @user.password = 'a1111１'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英字と半角文字の両方を含めて設定してください')
      end
      it 'パスワードが半角英字のみでは登録できない' do
        @user.password = 'aaaaaa'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英字と半角文字の両方を含めて設定してください')
      end
      it 'パスワードが半角数字のみでは登録できない' do
        @user.password = '111111'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワードは半角英字と半角文字の両方を含めて設定してください')
      end
      it 'パスワードとパスワード（確認）が不一致では登録できない' do
        @user.password = 'a11111'
        @user.password_confirmation = 'b22222'
        @user.valid?
        expect(@user.errors.full_messages).to include('パスワード（確認用）とパスワードの入力が一致しません')
      end
      it 'お名前（全角）は、名字が空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前を入力してください')
      end
      it 'お名前（全角）は、名前が空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字を入力してください')
      end
      it 'お名前（全角）は、名字を全角（漢字・ひらがな・カタカナ）で入力しなければ登録できない' do
        @user.last_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前は全角文字で入力してください')
      end
      it 'お名前（全角）は、名前を全角（漢字・ひらがな・カタカナ）で入力しなければ登録できない' do
        @user.first_name = 'test'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字は全角文字で入力してください')
      end
      it 'お名前カナ（全角）は、名字が空だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)を入力してください')
      end
      it 'お名前カナ（全角）は、名前が空だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('名字(カナ)を入力してください')
      end
      it 'お名前カナ（全角）は、名字を全角（カタカナ）で入力しないと登録できない' do
        @user.last_name_kana = 'ﾀﾛｳ'
        @user.valid?
        expect(@user.errors.full_messages).to include('お名前(カナ)は全角カナで入力してください')
      end
      it 'お名前カナ（全角）は、名前を全角（カタカナ）で入力しないと登録できない' do
        @user.first_name_kana = ' ﾔﾏﾀﾞ'
        @user.valid?
        expect(@user.errors.full_messages).to include('名字(カナ)は全角カナで入力してください')
      end
      it '生年月日が空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('生年月日を入力してください')
      end
    end
  end
end
