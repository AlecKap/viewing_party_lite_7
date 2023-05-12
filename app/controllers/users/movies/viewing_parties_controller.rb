class Users::Movies::ViewingPartiesController < ApplicationController
  def new
    @users = User.all
    @viewing_party = ViewingParty.new
    @facade = MovieDetailsFacade.new(params)
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      redirect_to user_path(viewing_party_params[:user_id])
    else
      flash[:notice] = 'Incorrect Info'
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:movie_title, :duration, :day, :start_time, :host)
  end
end