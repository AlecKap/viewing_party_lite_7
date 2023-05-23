class UsersController < ApplicationController
  def index
    @user_session = session[:user_id]
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
      session[:user_id] = user.id
      flash[:success] = "Welcome to Viewing Party, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:notice] = user.errors.full_messages.to_sentence
      redirect_to register_path
    end
  end

  def logout_of_session
    session[:user_id] = nil
    redirect_to root_path
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome back to Viewing Party lite, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:notice] = 'Sorry, these are not valid credentials. Please try again.'
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
