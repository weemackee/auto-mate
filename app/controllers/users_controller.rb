class UsersController < ApplicationController
  before_filter :authenticate, only: [:show]
  
  def index
    if logged_in?
      @user = User.find_by(id: current_user.id)
      render 'show'
    else
      @user = User.new
      render 'new'
    end
  end
  
  def show
    @user = User.find_by(id: current_user.id)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      params[:user][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_to @user
    else
      render 'new'
    end
  end  
  
  private
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end
