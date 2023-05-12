class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @facade = if params[:search] == 'top%20rated'
                TopRatedFacade.new
              elsif params[:search] == ''
                flash[:notice] = 'Search Field Cannot be Blank'
                redirect_to user_discover_index_path(@user)
              elsif params[:search].present?
                SearchFacade.new(params[:search])
              end
  end

  def show
    @facade = MovieDetailsFacade.new(params)
  end
end