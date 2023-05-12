class Users::Movies::ViewingPartiesController < ApplicationController
  def new
    @viewing_party = ViewingParty.new
    @facade = ViewingPartyFacade.new(params)
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.save
      flash[:notice] = 'Viewing Party Succesfully Created'
      redirect_to user_path(viewing_party_params[:host])
    else
      flash[:notice] = 'Incorrect Info'
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:movie_title, :duration, :day, :start_time, :host)
  end
end