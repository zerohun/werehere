class ApplicationController < ActionController::Base
  protect_from_forgery
  private
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  def authenticated?
    session[:user_id].present?
  end

  def require_authenticate
    redirect_to new_sessions_path if !authenticated?
  end

  def authenticate!
    redirect_to new_sessions_path 
  end

  helper_method :require_authenticate, 
                :current_user,
                :authenticated?

end
