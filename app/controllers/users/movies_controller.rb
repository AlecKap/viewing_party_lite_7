class Users::MoviesController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    if params[:search] == 'top%20rated'
      MovieFacade.new.top_rated
    elsif params[:search] == ''
      flash[:notice] = 'Search Field Cannot be Blank'
      redirect_to user_discover_index_path(@user)
    elsif params[:search].present?
      MovieFacade.new.search(params[:search])
    end
  end
end