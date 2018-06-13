class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  helper_method :log_in!, :current_user, :logged_in?, :log_out!
  
  def log_in!(user)
    session[:session_token] = user.reset_session_token!
  end  

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end
  
  def log_out!(user)
    current_user.reser_session_token!
    session[:session_token] = nil
  end

end
