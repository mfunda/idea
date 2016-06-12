class ForumPostsController < AdminDashboardController
  before_action :set_forum_post, only: [:show, :edit, :update, :destroy]

  def index
    @forum_posts = ForumPost.order(created_at: :desc).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @forum_replies = @forum_post.forum_replies
  end

  def new
    @forum_post = ForumPost.new
    @forum_categories = ForumCategory.all
  end

  def edit
    @forum_categories = ForumCategory.all
  end

  def create
    @forum_post = ForumPost.new(forum_post_params)
    @forum_post = current_user.forum_posts.build(forum_post_params)
    respond_to do |format|
      if @forum_post.save
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully created.' }
        format.json { render :show, status: :created, location: @forum_post }
      else
        format.html { render :new }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @forum_post.update(forum_post_params)
        format.html { redirect_to @forum_post, notice: 'Forum post was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_post }
      else
        format.html { render :edit }
        format.json { render json: @forum_post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forum_post.destroy
    respond_to do |format|
      format.html { redirect_to forum_posts_url, notice: 'Forum post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_forum_post
      @forum_post = ForumPost.find(params[:id])
    end

    def forum_post_params
      params.require(:forum_post).permit(:title, :content, :user_id, :forum_category_id)
    end
end
