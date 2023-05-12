class Users::MoviesController < ApplicationController
  def index
    @facade = if params[:search] == 'top%20rated'
                TopRatedFacade.new(params)
              elsif params[:search] == ''
                flash[:notice] = 'Search Field Cannot be Blank'
                redirect_to user_discover_index_path(params[:user_id])
              elsif params[:search].present?
                SearchFacade.new(params)
              end
  end

  def show
    @facade = MovieDetailsFacade.new(params)
  end
end