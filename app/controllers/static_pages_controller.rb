class StaticPagesController < ApplicationController
  def home
    @user = current_user
    @feed_items = Post.paginate(page: params[:page], per_page: 15)
    render :layout => 'home'
  end
end
