class PostsController < AdminDashboardController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @posts = Post.all unless params[:search_by_category].present?
    @posts = @categories.find(params[:search_by_category]).posts if params[:search_by_category].present?
    @posts = @posts.order(id: params[:order_by]) if params[:order_by].present?
    if params[:search_by_title].present?
      keywords = params[:search_by_title] = params[:search_by_title].gsub(',', ' ').squish.split
      @posts = @posts.where(keywords.map{|k| 'title LIKE \'%' + k + '%\''}.join(' or ') )
    end
    @posts = @posts.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @post = Post.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post = current_user.posts.build(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id, :category_id, :image, :description)
    end
end
