class AdminDashboardController < ApplicationController
	before_action :authenticate_user!
	before_action :authenticate_user_as_admin
	layout 'admin_dashboard'

	def index
		@users = User.all
		@posts = Post.all
		@pages = Page.all
		@categories = Category.all
		@comments = Comment.all
		@last_posts = @posts.limit(5).order(id: :desc)
		@last_comments = @comments.limit(5).order(id: :desc)
		@most_reply = @posts.joins('INNER JOIN comments ON posts.id = comments.post_id').group('posts.id').order('count(comments.id) DESC').limit(5)
	end

	protected

		def authenticate_user_as_admin
			permission_denied unless current_user.is_a?(Admin)
		end
end
