require 'rails_helper'


RSpec.describe UsersController, type: :controller do

  describe 'GET #index' do
    let(:taro) { FactoryBot.create(:taro) }
    let(:jiro) { FactoryBot.create(:jiro) }
    let(:users) { [taro, jiro] }

    context 'ユーザーがログインしている場合' do
      before do
        log_in(taro)
        get :index
      end

      it 'indexテンプレートをレンダリングすること' do
        expect(response).to render_template :index
      end

      it 'usersオブジェクトがviewに渡されること' do
        expect(assigns(:users)).to eq(users)
      end
    end

    context 'ユーザーがログインしていない場合' do
      before do
        get :index
      end

      it 'ログインページにリダイレクトされること' do
        expect(response).to redirect_to login_path
      end
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'レスポンスが200であること' do
      expect(response).to have_http_status(:ok)
    end

    it 'newテンプレートをレンダリングすること' do
      expect(response).to render_template :new
    end

    it '新しいuserオブジェクトがviewに渡されること' do
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe 'POST #create' do

    context '正しいユーザー情報が渡ってきた場合' do
      let(:params) do
        {
          user: {
            name:  "taro yamada",
            email: "a@a.com",
            password:              "password",
            password_confirmation: "password"
          }
        }
      end
      it 'ユーザーが一人増えていること' do
          expect {
            post :create, params: params
          }.to change(User, :count).by(1)
      end

      it 'マイページにリダイレクトされること' do
          expect(
            post :create, params: params
          ).to redirect_to(user_path(assigns(:user)))
      end
    end

    context '不正なユーザー情報が渡ってきた場合' do
      let(:params) do
        {
          user: {
            name:  "taro yamada",
            email: "a@a.com",
            password:              "password",
            password_confirmation: "invalidpassword"
          }
        }
      end
      it 'ユーザー数が変わらないこと' do
          expect {
            post :create, params: params
          }.to change(User, :count).by(0)
      end

      it '新規ユーザ登録ページにリダイレクトされること' do
          expect(
            post :create, params: params
          ).to render_template :new
      end
    end
  end
end
