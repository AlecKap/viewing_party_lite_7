require 'rails_helper'

RSpec.describe MovieImagesFacade do
  before :each do
    user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'FRIDAY4eva', password_confirmation: 'FRIDAY4eva')
    @params = {
      movie_id: 12444,
      id: user1.id
    }
    @facade = MovieImagesFacade.new(@params)
  end

  describe '#user', :vcr do
    it 'returns a integer' do
      expect(@facade.user).to be_a(User)
    end
  end

  describe '#movie_img', :vcr do
    it 'returns an image' do
      image_path = @facade.movie_img(@params[:movie_id])

      expect(image_path).to be_a(String)
    end
  end
end
