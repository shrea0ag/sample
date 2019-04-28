class UsersController < ApplicationController
	# attr_accessor :name, :email
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


private
def user_params
	params.require(:user).permit(:name, :email, :password, :password_confirmation)
end
end
