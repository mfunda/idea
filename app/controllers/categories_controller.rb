class CategoriesController < AdminDashboardController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    @categories = Category.all
    @categories = @categories.joins('LEFT OUTER JOIN posts ON categories.id = posts.category_id').group('categories.id').order('count(posts.id) ' + params[:order_by]) if params[:order_by].present?
    if params[:search].present?
      keywords = params[:search] = params[:search].gsub(',', ' ').squish.split
      @categories = @categories.where(keywords.map{|k| 'name LIKE \'%' + k + '%\''}.join(' or ') )
    end
    @categories = @categories.paginate(:page => params[:page], :per_page => 10)
  end

  def show
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    @category = current_user.categories.build(category_params)
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render :show, status: :created, location: @category }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @category }
      else
        format.html { render :edit }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name)
    end
end
