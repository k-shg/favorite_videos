class PostsController < ApplicationController
 before_action :logged_in_user, only: [:create]


 def new
   @post  = current_user.posts.build
   @post.comments.build
 end

 def create
   @post = current_user.posts.build(post_params)
   @post.youtube_url = params[:post][:youtube_url].last(11)

   result = find_videos('snippet', @post.youtube_url)

   if result.items.present?
     title = result.items.first.snippet.title
     @post.title = title
   end

   if @post.save!
     flash[:success] = "動画を投稿しました"
     redirect_to root_url
   else
     flash[:error] = "動画を投稿できませんでした"
     redirect_to current_user
   end
 end

 def show
   @post = Post.find(params[:id])
   @like = Like.new
   @comments = @post.comments.order(id: "DESC")
   @comment = Comment.new
   @category = Category.find_by(id: @post.category_id).name if @post.category_id
 end

 def destroy
 end

 def search
   @post = current_user.posts.build if logged_in?
   @search_word = params[:search]
   @order = params[:order]
   @feed_items = Post.search(params).paginate(page: params[:page], per_page: 15)
  # render :layout => 'home'
   render template: 'static_pages/home', layout: 'home'
 end

 def check
   #
   @post  = current_user.posts.build
   @post.comments.build

   @post.youtube_url = youtube_url = params[:ajax_handler]

   result = find_videos('snippet', @post.youtube_url.last(11))


   if result.items.present?
     title = result.items.first.snippet.title
     @post.title = result.items.first.snippet.title
     @post.channel_title = result.items.first.snippet.channel_title
   end



   render 'new'

 end

 private

   def post_params
     params.require(:post).permit(:youtube_url, :category_id, :order, comments_attributes:[:title, :content, :user_id])
   end

end
