class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where(role: 0)
  end

  def show
    user = User.find(params[:id])
    @facade = MovieImagesFacade.new(user)
  end

  private

  def require_admin
    render file: 'public/404.html' unless current_admin?
  end
end
