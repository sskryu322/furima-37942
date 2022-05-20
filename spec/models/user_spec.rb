require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it 'nickname、email、password、password_confirmation、last_name、first_name、last_name_pseudonym_reading、first_name_pseudonym_reading、birthdayが存在すれば登録できる' do
        expect(@user).to be_valid
      end
    end
    context '新規登録できない場合' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'last_nameが空では登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
      it 'first_nameが空では登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end
      it 'last_name_pseudonym_readingが空では登録できない' do
        @user.last_name_pseudonym_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name pseudonym reading can't be blank",
                                                      'Last name pseudonym reading is invalid')
      end
      it 'first_name_pseudonym_readingが空では登録できない' do
        @user.first_name_pseudonym_reading = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name pseudonym reading can't be blank",
                                                      'First name pseudonym reading is invalid')
      end
      it 'birthdayが空では登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
      it 'emailは@を含まないと登録できない' do
        @user.email = 'hoge.jp'
        @user.valid?
        expect(@user.errors.full_messages).to include('Email is invalid')
      end
      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'passwordが5文字以下では登録できない' do
        @user.password = 'a1234'
        @user.password_confirmation = 'a1234'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'passwordが129文字以上では登録できない' do
        @user.password = '1a' + Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too long (maximum is 128 characters)')
      end
      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = 'a123456'
        @user.password_confirmation = 'a12345678'
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it 'passwordが数字だけでは登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'passwordが英字だけでは登録できない' do
        @user.password = 'abcdef'
        @user.password_confirmation = 'abcdef'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is invalid')
      end
      it 'last_nameが英字では登録できない' do
        @user.last_name = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it 'first_nameが英字では登録できない' do
        @user.first_name = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it 'last_name_pseudonym_readingがひらがなでは登録できない' do
        @user.last_name_pseudonym_reading = 'やまだ'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name pseudonym reading is invalid')
      end
      it 'last_name_pseudonym_readingが英字では登録できない' do
        @user.last_name_pseudonym_reading = 'yamada'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name pseudonym reading is invalid')
      end
      it 'first_name_pseudonym_readingがひらがなでは登録できない' do
        @user.first_name_pseudonym_reading = 'たろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name pseudonym reading is invalid')
      end
      it 'first_name_pseudonym_readingが英字では登録できない' do
        @user.first_name_pseudonym_reading = 'taro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name pseudonym reading is invalid')
      end
    end
  end
end
