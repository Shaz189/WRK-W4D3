class SessionsController < ApplicationController
  
  def new 
    @user = User.new 
    render :new
  end
  
  def create 
    user = User.find_by_credentials(user_params)
    if user 
      log_in!(user)
      render root_url
    else 
      redirect_to new_session_url
    end
  end 
  
  def destroy 
    log_out!(current_user)
    redirect_to root_url
  end
  
end