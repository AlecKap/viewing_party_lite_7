require 'rails_helper'

RSpec.describe Movie do
  it 'exists' do
    attrs = {
      title: 'Your Name',
      vote_average: 9.2
    }

    movie = Movie.new(attrs)

    expect(movie).to be_a Movie
    expect(movie.title).to eq('Your Name')
    expect(movie.vote_average).to eq(9.2)
  end
end