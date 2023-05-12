require 'rails_helper'

RSpec.describe TopRatedFacade, :vcr do
  before(:each) do
    @user = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com')
    @params = { user_id: @user.id, search: 'top%20rated' }
    @facade = TopRatedFacade.new(@params)
  end

  it 'returns an array of movies' do
    expect(@facade.movies).to be_a(Array)
    expect(@facade.movies.first).to be_a(Movie)
  end

  it 'returns user id' do
    expect(@facade.user_id).to be_a(Integer)
  end
end