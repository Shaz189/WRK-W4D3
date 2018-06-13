class UsersController < ApplicationController
  def new 
    @user = User.new
    render :new
  end
  
  def create 
    # debugger
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user 
     redirect_to new_session_url
    else 
      @user = User.new(user_params)
      if @user.save
        log_in!(@user)
        redirect_to cats_url
      else 
        redirect_to new_user_url
      end
    end
  end    
  
  
  private
  
  def password(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end
  
  def user_params
    params.require(:users).permit(:username, :password)
  end 
end