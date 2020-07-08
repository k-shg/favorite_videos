class PostsController < ApplicationController

 def create
   @post = current_user.posts.build(post_params)
   @post.youtube_url = params[:post][:youtube_url].last(11)

   result = find_videos('snippet', @post.youtube_url)

   if result.items.present?
     title = result.items.first.snippet.title
     @post.title = title
   end

   if @post.save
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

   if logged_in?
     @post = current_user.posts.build
   end

   @search_word = params[:search]
   @order = params[:order]
   @feed_items = Post.search(params).paginate(page: params[:page], per_page: 15)

   render 'static_pages/home'
 end

 private

   def post_params
     params.require(:post).permit(:youtube_url, :category_id, :order)
   end

end
