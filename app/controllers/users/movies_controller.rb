class Users::MoviesController < ApplicationController
  def index
    @facade = top_rated_or_search
  
  end

  def show
    @facade = MovieDetailsFacade.new(current_user, params[:id])
  end

  private

  def top_rated_or_search
    if params[:search] == 'top%20rated'
      TopRatedFacade.new(current_user)
    elsif params[:search] == ''
      flash[:notice] = 'Search Field Cannot be Blank'
      redirect_to users_discover_path
    elsif params[:search].present?
      SearchFacade.new(current_user, params[:search])
    end
  end
end