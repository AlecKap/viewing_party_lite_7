class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @movies = if params[:search] == 'top%20rated'
                MoviesFacade.new.top_rated
              elsif params[:search] == ''
                flash[:notice] = 'Search Field Cannot be Blank'
                redirect_to user_discover_index_path(@user)
              elsif params[:search].present?
                MoviesFacade.new.search(params[:search])
              end
  end
end