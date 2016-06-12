class ForumCategoriesController < AdminDashboardController
  before_action :set_forum_category, only: [:show, :edit, :update, :destroy]

  def index
    @forum_categories = ForumCategory.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @forum_posts = @forum_category.forum_posts.paginate(:page => params[:page], :per_page => 10)
  end

  def new
    @forum_category = ForumCategory.new
  end

  def edit
  end

  def create
    @forum_category = ForumCategory.new(forum_category_params)
    @forum_category = current_user.forum_categories.build(forum_category_params)
    respond_to do |format|
      if @forum_category.save
        format.html { redirect_to @forum_category, notice: 'Forum category was successfully created.' }
        format.json { render :show, status: :created, location: @forum_category }
      else
        format.html { render :new }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @forum_category.update(forum_category_params)
        format.html { redirect_to @forum_category, notice: 'Forum category was successfully updated.' }
        format.json { render :show, status: :ok, location: @forum_category }
      else
        format.html { render :edit }
        format.json { render json: @forum_category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @forum_category.destroy
    respond_to do |format|
      format.html { redirect_to forum_categories_url, notice: 'Forum category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_forum_category
      @forum_category = ForumCategory.find(params[:id])
    end

    def forum_category_params
      params.require(:forum_category).permit(:name, :user_id)
    end
end
