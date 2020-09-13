class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  def new
  	# Login Page - new.html.erb
  end

  def create
  	user = User.find (user_params[:email])
  	password = user_params [:password]

  	if user && user.authenticate(password)
  	  session[:user_id] = user.id
  	  redirect_to root_path, notice: "Logged in successfully"
  	else
  	  redirect_to login_path, alert: "Invalid username/password combination"
  	end
  end

  def destroy
  	reset_session # wipe out session and everything in it
    redirect_to login_path, notice: "You have been logged out"
  end


private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.permit(:email, :password )
  end

end
