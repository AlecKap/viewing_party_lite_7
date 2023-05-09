class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:notice] = 'Unable to Register: Email Already in Use or Missing Input'
      redirect_to register_path
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email)
  end
end