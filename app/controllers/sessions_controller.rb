class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create 
    @user = User.find_by_email(params[:session][:email].downcase)
    
    if @user && @user.authenticate(params[:session][:password])
      login @user
      redirect_to @user
    else
      render 'login'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
