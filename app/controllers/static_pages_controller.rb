class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @post  = current_user.posts.build
    end
    @feed_items = Post.paginate(page: params[:page], per_page: 15)
  end
end
