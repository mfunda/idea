class HomeController < ApplicationController


	def index
		@posts = Post.last(5)
		@posts = @posts.sort_by{|post| post.id}.reverse
	end
end
