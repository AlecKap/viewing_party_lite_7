class Users::MoviesController < ApplicationController
  def index
    @facade = top_rated_or_search
  end

  def show
    if current_user
      @facade = MovieDetailsFacade.new(current_user, params[:id])
    else
      flash[:notice] = 'lol... nice try, but you must login to access the page you are looking for.'
      redirect_to root_path
    end
  end

  private

  def top_rated_or_search
    if params[:search] == 'top%20rated'
      TopRatedFacade.new(params)
    elsif params[:search] == ''
      flash[:notice] = 'Search Field Cannot be Blank'
      redirect_to users_discover_path
    elsif params[:search].present?
      SearchFacade.new(params)
    end
  end
end