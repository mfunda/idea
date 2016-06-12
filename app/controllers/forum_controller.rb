class ForumController < ApplicationController

	before_action :authenticate_user!, only: [:new_topic, :create_topic, :new_reply, :create_reply]

	def index
		@posts = ForumPost.order('created_at DESC').paginate(:page => params[:page], :per_page => 10)
		@categories = ForumCategory.all
	end

	def show
		@post = ForumPost.find(params[:id])
		@forum_replies = @post.forum_replies
		@reply = ForumReply.new
	end

	def show_forum_category
		@categories = ForumCategory.all
		@posts = ForumPost.where(forum_category_id: params[:id]).paginate(:page => params[:page], :per_page => 10)
	end

	def forum_categories_list
		@categories = ForumCategory.paginate(:page => params[:page], :per_page => 10)
	end

	def new_topic
		@post = ForumPost.new
		@categories = ForumCategory.all
	end

	def create_topic
	 	@post = ForumPost.new(post_params)
	    @post = current_user.forum_posts.build(post_params)
		if @post.save
			redirect_to show_topic_path(@post)
		else
			render new_topic_path(@post)
		end
	end

	def new_reply
		redirect_to show_topic_path(ForumPost.find(params[:id]))
	end

	def create_reply
	 	@post = ForumPost.find(params[:id])
	    @reply = @post.forum_replies.build(reply_params)
	    @reply.user_id = current_user.id
		if @reply.save
			redirect_to show_topic_path(@post)
		else
			render show_topic_path(@reply.forum_post_id)
		end
	end

	private

    def set_post
      @post = ForumPost.find(params[:id])
    end

    def post_params
      params.require(:forum_post).permit(:title, :content, :user_id, :forum_category_id)
    end

    def reply_params
      params.require(:forum_reply).permit(:content, :user_id, :forum_post_id)
    end

end
