class UsersController < ApplicationController
	# attr_accessor :name, :email
    before_action :logged_in_user, only: [:index , :edit, :update, :destroy]
    before_action :correct_user , only:[:edit, :update]
    before_action :admin_user,     only: :destroy

  def index
   @users = User.paginate(page: params[:page])
  end

  def new
  	@user = User.new
  end

  def show
   @user = User.find(params[:id])
  end

  def create
  	@user = User.new(user_params)
  	
  	if @user.save
      log_in @user
      remember(@user)
  		redirect_to @user
      flash[:success] = "Welcome #{@user.name}"
  	else
  		render 'new'
  	end
  end

  def edit
   
  end

  def update

    if @user.update_attributes(user_params)
      flash[:success] = "update successfully #{@user.name}"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end


  private
  def user_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "please log in"
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to root_url unless current_user?(@user)
  end

end
