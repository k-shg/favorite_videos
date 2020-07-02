class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @users = User.paginate(page: params[:page], per_page: 20)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:info] = "Please check your email to activate your account."
      redirect_to @user
    else
     render 'new'
   end
  end

  def show
    if logged_in?
      @post  = current_user.posts.build
    end
    @user = User.find(params[:id])
    @posts = @user.posts.paginate(page: params[:page])
    @favorite_posts = @user.liked_posts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:image]
      #データベースに保存するファイル名はユーザーのid.jpgとする
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}",image.read)
    else
      @user.remove_image!
    end

    if @user.update_attributes(user_params)
      redirect_to @user
    else
      render 'new'
    end
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def search

    # if logged_in?
    #   @post  = current_user.posts.build
    # end

    @search_word = params[:search]
    @users = User.search(params[:search]).paginate(page: params[:page])

    render 'users/index'
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :image)
    end

    # ログイン済みユーザーかどうか確認
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # 正しいユーザーかどうか確認
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
