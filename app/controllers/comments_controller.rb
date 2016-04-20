class CommentsController < AdminDashboardController
  before_action :set_comment, only: [:show, :edit, :update, :destroy, :approve_comment, :disapprove_comment]

  def index
    @comments = Comment.all
    @posts = Post.all
    @comments = @comments.order(id: params[:order_by]) if params[:order_by].present?
    @comments = @comments.where(approved: params[:approve]) if params[:approve].present?
    if params[:search].present?
      keywords = params[:search] = params[:search].gsub(',', ' ').squish.split
      @posts = @posts.where(keywords.map{|k| 'title LIKE \'%' + k + '%\'' }.join(' or ') )
      @comments = @comments.where(keywords.map{|k| 'content LIKE \'%' + k + '%\'' }.join(' or ') ) + @comments.where(post_id: @posts.ids)
      @comments = @comments.uniq.sort_by {|c| c.id}.reverse if params[:order_by].present? and params[:order_by] == 'desc'
      @comments = @comments.uniq.sort_by {|c| c.id} unless params[:order_by].present? and params[:order_by] == 'desc'
    end
    @comments = @comments.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @comment = Comment.new
    @posts = Post.all
  end

  def edit
  	@posts = Post.all
  end

  def approve_comment
  	@comment.approved = true
  	@comment.save
  	respond_to do |format|
        format.html { redirect_to comments_url, notice: 'Comment was successfully approved.' }
        format.json { render :no_content }
    end
  end

  def disapprove_comment
  	@comment.approved = false
  	@comment.save
  	respond_to do |format|
        format.html { redirect_to comments_url, notice: 'Comment was successfully disapproved.' }
        format.json { render :no_content }
    end
  end

  def create
    @comment = Comment.new(comment_params)
    @comment = current_user.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment, notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:content, :post_id, :user_id, :approve_comment)
    end
end
