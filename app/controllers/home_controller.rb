class HomeController < ApplicationController


	def index
		@posts = Post.all
		@posts = @posts.sort_by{|post| post.id}.reverse
		@pages = Page.all
		@categories = Category.all
	end

	def show_post
		@post = Post.find(params[:id])
		@comments = @post.comments
	end

	def show_page
		@page = Page.find(params[:id])
	end

	def show_user_profile
		@user = User.find(params[:id])
	end

	def show_category
		@category = Category.find(params[:id])
	end

end
