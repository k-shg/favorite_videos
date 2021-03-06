class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      flash[:success] = "ログインしました"
      redirect_back_or @user
    else
      flash.now[:error] = 'emailまたはパスワードの組み合わせが間違っています'
      render 'new'
    end
  end

  def new_guest
    user = User.find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'guest'
      user.image = 'guest.jpeg'
      user.password = SecureRandom.urlsafe_base64
    end
    log_in user
    flash[:success] = 'ゲストユーザーとしてログインしました'
    redirect_to root_path
  end

  def destroy
    log_out
    flash[:success] = "ログアウトしました"
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

end
