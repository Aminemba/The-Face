class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  include SessionsHelper

  helper_method :logged_in?, :current_user

  def authenticate_user
    if @current_user == nil
      flash[ :notice ]= t('notice.login_needed')
      redirect_to new_session_path
    end
  end



  protected

    def logged_in?
      session[:user_id] # nil is false
    end

    def current_user
      @current_user ||= user.find(session[:user_id])
    end




end
