require 'rails_helper'

RSpec.describe TopRatedFacade, :vcr do
  before(:each) do
    @user = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com', password: 'password123', password_confirmation: 'password123')
    @facade = TopRatedFacade.new(@user)
  end

  it 'returns an array of movies' do
    expect(@facade.movies).to be_a(Array)
    expect(@facade.movies.first).to be_a(Movie)
  end

  it 'returns a User object' do
    expect(@facade.user).to be_a(User)
  end
end