class HomeController < ApplicationController


	def index
		@posts = Post.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
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
