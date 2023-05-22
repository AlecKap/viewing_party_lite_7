class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @facade = MovieImagesFacade.new(params)
  end

  def new
    @user = User.new
  end

  def create
    new_user = User.new(user_params)
    if user.save
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.username}!"
      redirect_to user_path(new_user)
    else
      flash[:notice] = 'Unable to Register: Email Already in Use or Missing Input'
      render :new
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end