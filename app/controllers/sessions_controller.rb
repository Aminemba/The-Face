class SessionsController < ApplicationController

  def new
  	# Login Page - new.html.erb
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:danger] = 'failed to login'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[ :notice ]= ' logged out '
    redirect_to new_session_path
  end


private
  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.permit(:name, :email, :password , :password_confirmation )
  end

end