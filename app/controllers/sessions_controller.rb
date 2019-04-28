class SessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email:  params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  		log_in user
  		redirect_to user

  	else
  		flash.now[:danger] = "you have typed something wrong"
  		render 'new'
  		# redirect_to login_path
  	end
  end

  	def current_user
    	if session[:user_id]
      		@current_user ||= User.find_by(id: session[:user_id])
    	end
  	end


  def destroy
    log_out
    redirect_to root_url

  end
end
