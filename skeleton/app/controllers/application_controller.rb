class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  
  helper_method :log_in!, :current_user, :logged_in?, :log_out!, :ensure_logged_in, :current_cat, :current_user_cats
  
  def log_in!(user)
    debugger
    session[:session_token] = user.reset_session_token!
  end  

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end
  
  def log_out!(user)
    current_user.reset_session_token!
    session[:session_token] = nil
  end
  
  def ensure_logged_in
    redirect_to new_session_url unless logged_in?
  end

  
  def current_cat 
    Cat.find(params[:id])
  end
  
  def current_user_cats
    redirect_to cats_url unless current_cat.owner_id == current_user.id
  end
  
end
