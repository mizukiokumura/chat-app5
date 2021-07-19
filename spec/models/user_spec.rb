require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    it 'nameとemail,password_confirmationが存在すれば登録できること' do
      expect(@user).to be_valid
    end
    it 'nameが空では登録できないこと' do
      @user.name = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Name can't be blank")
    end
    it 'emailが空では登録できない事' do
      @user.email = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'passwordが空では登録できない事' do
      @user.password = ''
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it 'passwordが6文字以上であれば登録できる事' do
      @user.password = 'hogehoge'
      @user.password_confirmation = "hogehoge"
      expect(@user).to be_valid
    end
    it 'passwordが5文字以下であれば登録できない事'do
      @user.password = '55555'
      @user.password_confirmation = '55555'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
    it 'passowrdとpassword_confirmationが不一致では登録できないこと' do
      @user.password = 'hogehoge'
      @user.password_confirmation = 'hogehuga'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it '重複したemailが存在する場合登録できないこと' do
      user = FactoryBot.build(:user)
      user.save
      @user.email = user.email
      @user.valid?
      expect(@user.errors.full_messages).to include("Email has already been taken")
      
      # @user.save
      # another_user = FactoryBot.build(:user, email: @user.email)
      # another_user.valid?
      # expect(another_user.errors.full_messages).to include('Email has already been taken')
    end
  end
end
