class UsersController < AdminDashboardController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @users = @users.where('login LIKE \'%' + params[:search] + '%\' 
      or first_name LIKE \'%' + params[:search] + '%\' 
      or last_name LIKE \'%' + params[:search] + '%\'') if params[:search]
    @users = @users.where(role: params[:role]) if params[:role].present? and params[:role] == 'Admin'
    @users = @users.where(role: nil) if params[:role].present? and params[:role] == 'User'
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end


  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user), notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params[:user][:role] = nil if params[:user].present? and params[:user][:role].blank?
      params[:user][:password] = nil if params[:user].present? and params[:user][:password] == ''
      params[:user][:password_confirmation] = nil if params[:user].present? and params[:user][:password_confirmation] == ''
      params.require(:user).permit(:first_name, :last_name, :login, :email, :password, :password_confirmation, :role, :avatar)
    end
end
