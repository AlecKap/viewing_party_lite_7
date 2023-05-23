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
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user)
    else
      flash[:notice] = user.errors.full_messages
      redirect_to register_path
    end
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      flash[:success] = "Welcome back to Viewing Party lite, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:notice] = 'Sorry, these are not credentials. Please try again.'
      render :login_form
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
