require 'rails_helper'

RSpec.describe Post, type: :model do
  FactoryBot.use_parent_strategy = false
  let(:user) { FactoryBot.build(:taro) }
  let(:post) { FactoryBot.build(:one) }

  #pending 'postファクトリーにuserを関連付しようとするとuser_idが空になる'
  #→rails5からbuildの挙動が変わり、関連付されなくなったため

  describe 'バリデーションが機能していること' do

    describe  '項目が存在していること' do

      context '全ての項目が適切に入力されている場合' do
        it 'エラーメッセージが出力されないこと' do
          post.valid?
          expect(post).to be_valid
          expect(post.errors.messages).to be_blank
        end
      end

      context 'ユーザーのアソシエーションがない場合' do
        let(:post) { build(:one, user_id: nil) }
        it 'エラーメッセージが出力されること' do
          post.valid?
          expect(post.errors[:user_id]).not_to be_blank
        end
      end

      context 'タイトルがない場合' do
        let(:post) { build(:one, title: nil) }
        it 'エラーメッセージが出力されること' do
          post.valid?
          expect(post.errors[:title]).not_to be_blank
        end
      end

      context '動画URLがない場合' do
        let(:post) { build(:one, youtube_url: nil) }
        it 'エラーメッセージが出力されること' do
          post.valid?
          expect(post.errors[:youtube_url]).not_to be_blank
        end
      end

    end

    describe '文字数制限を満たしていること' do
      context 'タイトルが100文字以上の場合' do
        let(:post) { build(:one, title: 'a'* 101) }
        it 'エラーメッセージが出力されること' do
          post.valid?
          expect(post.errors[:title]).not_to be_blank
        end
      end

      context '動画URLが12文字以上の場合' do
        let(:post) { build(:one, youtube_url: 'a'* 12) }
        it 'エラーメッセージが出力されること' do
          post.valid?
          expect(post.errors[:youtube_url]).not_to be_blank
        end
      end
    end
  end
end
