class Users::Movies::ViewingPartiesController < ApplicationController
  def new
    @facade = ViewingPartyFacade.new(params)
  end

  def create
    viewing_party = ViewingParty.new(viewing_party_params)
    if viewing_party.duration_check && viewing_party.save
      viewing_party.create_user_viewing_parties
      flash[:notice] = 'Viewing Party Succesfully Created'
      redirect_to user_path(viewing_party_params[:host])
    else
      flash[:notice] = 'All fields must be filled in and duration must be greater than movie runtime'
      render :new
    end
  end

  private

  def viewing_party_params
    params.require(:viewing_party).permit(:movie_title, :duration, :day, :start_time, :host)
  end
end