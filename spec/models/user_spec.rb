require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:taro) }
  #let(:taro) { FactoryBot.build(:taro) }

  describe 'バリデーションが機能していること' do

    describe  '項目が存在していること' do

      context '全ての項目が適切に入力されている場合' do
        it 'エラーメッセージが出力されないこと' do
          user.valid?
          expect(user).to be_valid
          expect(user.errors.messages).to be_blank
        end
      end

      context 'nameがない場合' do
        let(:user) { build(:taro, name: '') }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:name]).not_to be_blank
        end
      end

      context 'emailがない場合' do
        let(:user) { build(:taro, email: '') }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:email]).not_to be_blank
        end
      end

      context 'passwordがない場合' do
        let(:user) { build(:taro, password: '') }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:password]).not_to be_blank
        end
      end
    end


    describe '文字数制限を満たしていること' do
      context 'nameが50文字以上の場合' do
        let(:user) { build(:taro, name: 'a'* 51) }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:name]).not_to be_blank
        end
      end

      context 'emailが255文字以上の場合' do
        let(:user) { build(:taro, email: 'a'* 266 + "@samle.com") }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:email]).not_to be_blank
        end
      end

      context 'passwordが6文字未満の場合' do
        let(:user) { build(:taro, password: 'a'* 5, password_confirmation: 'a'* 5) }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:password]).not_to be_blank
        end
      end
    end

    describe 'passwordとpassword_confirmationが一致していること' do
      context '一致している場合' do
        let(:user) { build(:taro, password: 'a'* 6, password_confirmation: 'a'* 6) }
        it 'エラーメッセージが出力されるないこと' do
          user.valid?
          expect(user.errors[:password_confirmation]).to be_blank
        end
      end
      context '一致していない場合' do
        let(:user) { build(:taro, password: 'a'* 6, password_confirmation: 'a'* 7) }
        it 'エラーメッセージが出力されること' do
          user.valid?
          expect(user.errors[:password_confirmation]).not_to be_blank
        end
      end
    end

  end

end
