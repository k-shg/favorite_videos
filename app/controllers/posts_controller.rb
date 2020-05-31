class PostsController < ApplicationController

 def create
   @post = current_user.posts.build(post_params)
   @post.youtube_url = params[:post][:youtube_url].last(11)

   result = find_videos('snippet', @post.youtube_url)

   puts result.to_h
   title = result.items.first.snippet.title

   @post.title = title

   if @post.save
     flash[:success] = "post created!"
     redirect_to root_url
   else
     @feed_items = []
     render 'static_pages/home'
   end
 end

 def show
   @post = Post.find(params[:id])
   @like = Like.new
 end

 def destroy
 end

 private

   def post_params
     params.require(:post).permit(:youtube_url)
   end

end
