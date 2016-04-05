class CommentsController < ApplicationController
	
	before_action :authenticate_user!

  	def create
		@post = Post.find(params[:post_id])
		@comment = Comment.create(params[:comment].permit(:content))
		@comment.user_id = current_user.id
		@comment.post_id = @post.id

		if @comment.save
			redirect_to :back
		else
			render 'new'
		end
	end

	def destroy
		@comment = Comment.find(params[:id])
    	@comment.destroy
    	redirect_to :back
    end
  end
end

