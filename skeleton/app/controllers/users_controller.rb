class UsersController < ApplicationController
  def new 
    @user = User.new
    render :new
  end
  
  def create 
    user = User.find_by_credentials(user_params)
    if user 
     redirect_to new_session_url
    else 
      user = User.new(user_params)
      if user.save
        # render :
      end
    end
  end    
  
  private
  def user_params
    params.require(:user).permit(:username, :password)
  end 
end