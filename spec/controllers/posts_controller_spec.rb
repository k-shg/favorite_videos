# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:posted) { FactoryBot.create(:one) }
  let(:user) { FactoryBot.create(:taro) }

  describe 'GET #index' do
    before do
      get :show, params: { id: posted.id }
    end

    it 'indexテンプレートをレンダリングすること' do
      expect(response).to be_success
      expect(response).to render_template :show
    end

    it '新しいlikeオブジェクトがviewに渡されること' do
      expect(assigns(:like)).to be_a_new(Like)
    end

    it '新しいcommentオブジェクトがviewに渡されること' do
      expect(assigns(:comment)).to be_a_new(Comment)
    end

    pending '既存のcommentsオブジェクトがviewに渡されること'

    it '適切なpostオブジェクトがviewに渡されること' do
      expect(assigns(:post)).to eq(posted)
    end
  end

  describe 'POST #create' do
    context 'ユーザーがログインしている場合' do
      before { log_in(user) }
      context '正しい投稿情報が渡ってきた場合' do
        let(:params) do
          {
            post: {
              title: 'バスケを知らない人に見せたいダンク',
              youtube_url: 'SsmfYJEamyU',
              category_id: 2
            }
          }
        end

        it '投稿が一つ増えていること' do
          expect do
            post :create, params: params
          end.to change(Post, :count).by(1)
        end

        it 'ルートページにリダイレクトされ���こと' do
          expect(
            post(:create, params: params)
          ).to redirect_to root_url
        end
      end

      context '不正な投稿情報が渡ってきた場合' do
        let(:params) do
          {
            post: {
              title: 'sampletitle',
              youtube_url: '',
              category_id: 2
            }
          }
        end

        it '投稿数が変わらないこと' do
          expect do
            post :create, params: params
          end.to change(Post, :count).by(0)
        end

        it 'マイページにリダイレクトされること' do
          expect(
            post(:create, params: params)
          ).to redirect_to user_path(user)
        end
      end
    end

    context 'ユーザーがログインしていない場合' do
      let(:params) do
        {
          post: {
            title: 'バスケを知らない人に見せたいダンク',
            youtube_url: 'SsmfYJEamyU',
            category_id: 2
          }
        }
      end

      it '投稿数が変わらないこと' do
        expect do
          post :create, params: params
        end.to change(Post, :count).by(0)
      end

      it 'ログインページにリダイレクトされること' do
        expect(
          post(:create, params: params)
        ).to redirect_to login_path
      end
    end
  end
end
