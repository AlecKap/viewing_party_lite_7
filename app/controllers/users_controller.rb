class UsersController < ApplicationController
  before_action :require_user, only: [:show]

  def index
    @users = User.all
  end

  def show
    @facade = MovieImagesFacade.new(current_user)
  end

  def new
    @user = User.new
  end

  def create
    begin
      new_user = User.create!(user_params)
      session[:user_id] = new_user.id
      flash[:success] = "Welcome, #{new_user.name}!"
      redirect_to dashboard_path
    rescue ActiveRecord::RecordInvalid => e
      flash[:notice] = e.message
      redirect_to register_path
    end
  end

  def login_form
  end

  def login
    user = User.find_by(name: params[:name])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}"
      redirect_to root_path
    else
      flash[:error] = 'Invalid name or password'
      redirect_to login_path
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def require_user
    unless current_user
      flash[:error] = 'You must be logged in or register to view this page'
      redirect_to root_path
    end
  end
end