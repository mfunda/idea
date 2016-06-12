class ForumController < ApplicationController

	def index
		@posts = ForumPost.order('created_at DESC').paginate(:page => params[:page], :per_page => 5)
	end
end
