require 'rails_helper'

RSpec.describe MovieService do
  context 'class methods' do
    context '#top_rated_movies', :vcr do
      it 'returns movie data' do
        search = MovieService.new.top_rated_movies
        expect(search).to be_a(Hash)
        expect(search[:results]).to be_an(Array)
        movie_data = search[:results].first

        expect(movie_data).to have_key(:title)
        expect(movie_data[:title]).to be_a(String)

        expect(movie_data).to have_key(:vote_average)
        expect(movie_data[:vote_average]).to be_a(Float)
      end
    end

    context 'search_movies' do
      context '#top_rated_movies', :vcr do
        it 'returns movie data' do
          search = MovieService.new.search_movies('Godzilla')
          expect(search).to be_a(Hash)
          expect(search[:results]).to be_an(Array)
          movie_data = search[:results].first
  
          expect(movie_data).to have_key(:title)
          expect(movie_data[:title]).to be_a(String)
  
          expect(movie_data).to have_key(:vote_average)
          expect(movie_data[:vote_average]).to be_a(Float)
        end
      end
    end
  end
end