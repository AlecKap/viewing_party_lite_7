class Users::MoviesController < ApplicationController
  # before_action :require_user, only: [:index, :show]

  def index
    @facade = if params[:search] == 'top%20rated'
                TopRatedFacade.new(current_user, params)
              elsif params[:search] == ''
                flash[:notice] = 'Search Field Cannot be Blank'
                redirect_to discover_index_path
              elsif params[:search].present?
                SearchFacade.new(current_user, params)
              end
  end

  def show
    @facade = MovieDetailsFacade.new(params)
  end

  private

  def require_user
    unless current_user
      flash[:error] = 'You must be logged in or register to view this page'
      redirect_to user_movies_path
    end
  end
end