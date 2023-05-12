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

    context '#search_movies', :vcr do
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

    context '#movie_details', :vcr do
      it 'returns movie data' do
        search = MovieService.new.movie_details('12444')
        expect(search).to be_a(Hash)

        expect(search).to have_key(:title)
        expect(search[:title]).to be_a(String)

        expect(search).to have_key(:vote_average)
        expect(search[:vote_average]).to be_a(Float)

        expect(search).to have_key(:runtime)
        expect(search[:runtime]).to be_a(Integer)

        expect(search).to have_key(:genres)
        expect(search[:genres]).to be_a(Array)

        expect(search).to have_key(:overview)
        expect(search[:overview]).to be_a(String)
      end
    end

    context '#movie_cast', :vcr do
      it 'returns movie data' do
        search = MovieService.new.movie_cast('12444')
        expect(search).to be_a(Hash)
        expect(search[:cast]).to be_an(Array)
        cast_data = search[:cast].first

        expect(cast_data).to have_key(:name)
        expect(cast_data[:name]).to be_a(String)

        expect(cast_data).to have_key(:character)
        expect(cast_data[:character]).to be_a(String)
      end
    end

    context '#movie_reviews_details', :vcr do
      it 'returns movie data' do
        search = MovieService.new.movie_reviews_details('12444')
        expect(search).to be_a(Hash)

        expect(search[:total_results]).to be_an(Integer)

        expect(search[:results]).to be_an(Array)
        review_data = search[:results].first

        expect(review_data).to have_key(:content)
        expect(review_data[:content]).to be_a(String)
      end
    end
  end
end