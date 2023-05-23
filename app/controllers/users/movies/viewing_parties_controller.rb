class Users::Movies::ViewingPartiesController < ApplicationController
  def new
    @facade = ViewingPartyFacade.new(params)
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.duration_check && viewing_party.save
      viewing_party.create_user_viewing_parties(params)
      flash[:notice] = 'Viewing Party Succesfully Created'
      redirect_to dashboard_path
    else
      flash[:notice] = 'All fields must be filled in and duration must be greater than movie runtime'
      redirect_to new_user_movie_viewing_party_path(viewing_party_params[:host], viewing_party_params[:movie_id])
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:movie_title, :duration, :day, :start_time, :host, :movie_id, :movie_runtime)
  end
end