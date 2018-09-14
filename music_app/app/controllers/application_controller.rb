class ApplicationController < ActionController::Base

  def login!(user)
    session[:session_token] = user.reset_session_token
  end

  def current_user
    return nil unless session[:session_token]
    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def require_login!
    redirect_to new_session_url if current_user.nil?
  end



end
