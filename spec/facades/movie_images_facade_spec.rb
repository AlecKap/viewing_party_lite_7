require 'rails_helper'

RSpec.describe MovieImagesFacade do
  before :each do
    user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
    @movie_id = 12444
    @facade = MovieImagesFacade.new(user1)
  end

  describe '#user', :vcr do
    it 'returns a integer' do
      # binding.pry
      expect(@facade.user).to be_a(User)
    end
  end

  describe '#movie_img', :vcr do
    it 'returns an image' do
      image_path = @facade.movie_img(@movie_id)

      expect(image_path).to be_a(String)
    end
  end
end
