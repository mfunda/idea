class ForumRepliesController < AdminDashboardController
  before_action :set_forum_reply, only: [:show, :edit, :update, :destroy]

  def index
    @forum_replies = ForumReply.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @forum_reply = ForumReply.new
    @forum_posts = ForumPost.all
  end

  def edit
    @forum_posts = ForumPost.all
  end

  def create
    @forum_reply = ForumReply.new(forum_reply_params)
    @forum_reply = current_user.forum_replies.build(forum_reply_params)
    respond_to do |format|
      if @forum_reply.save
        format.html { redirect_to @forum_reply, notice: 'Forum reply was successfully created.' }
        format.json { render :show, status: :created, location: @forum_reply }
      else
        format.html { render :new }
        format.json { render json: @forum_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @forum_reply.update(forum_reply_params)
        format.html { redirect_to @forum_reply, notice: 'Forum reply was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_reply }
      else
        format.html { render :edit }
        format.json { render json: @forum_reply.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forum_reply.destroy
    respond_to do |format|
      format.html { redirect_to forum_replies_url, notice: 'Forum reply was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_forum_reply
      @forum_reply = ForumReply.find(params[:id])
    end

    def forum_reply_params
      params.require(:forum_reply).permit(:content, :user_id, :forum_post_id)
    end
end
