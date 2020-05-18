class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      log_in(@user)
      flash[:info] = "User logged in."
      redirect_back_or @user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end


  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
    def user_params
      params.require(:user).permit(:email, :password)
    end

end
