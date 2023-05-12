require 'rails_helper'

RSpec.describe MovieDetailsFacade do
  before :each do
    user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
    params = {
      id: 1891,
      user_id: user1.id
    }
    @facade = MovieDetailsFacade.new(params)
  end

  describe 'movie details', :vcr do
    describe '#user_id' do
      it 'returns a integer' do
        expect(@facade.user_id).to be_a(Integer)
      end
    end

    describe '#movie' do
      it 'returns a movie object' do
        expect(@facade.movie).to be_a(Movie)
      end
    end

    describe '#runtime' do
      it 'returns a integer' do
        expect(@facade.runtime).to be_a(Integer)
      end
    end

    describe '#genres' do
      it 'returns a string' do
        expect(@facade.genres).to be_a(String)
      end
    end
  end

  describe 'cast details' do
    describe '#cast', :vcr do
      it 'returns a string' do
        expect(@facade.cast).to be_a(String)
      end
    end
  end

  describe 'review details' do
    describe '#reviews', :vcr do
      it 'returns an array' do
        expect(@facade.reviews).to be_a(Array)
      end
    end

    describe '#total_reviews', :vcr do
      it 'returns an integer' do
        expect(@facade.total_reviews).to be_a(Integer)
      end
    end
  end
end
