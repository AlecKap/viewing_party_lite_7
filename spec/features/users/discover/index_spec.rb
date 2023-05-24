require 'rails_helper'

RSpec.describe 'Discover Movies Page' do
  describe "As a user, when I visit the '/users/:id/discover' path," do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit users_discover_path
    end

    it 'I see a Top Rated Movies button that redirects to the Movie Results page', :vcr do
      expect(page).to have_content('Discover Movies Page')
      expect(page).to have_link('Find Top Rated Movies')

      click_link 'Find Top Rated Movies'

      expect(current_path).to eq(movies_path)
    end

    it 'I see a text field to enter keyword(s) to search by movie title and a button to submit', :vcr do
      expect(page).to have_field('search')
      expect(page).to have_button('Find Movies')

      fill_in 'search', with: 'Lion'
      click_button 'Find Movies'

      expect(current_path).to eq(movies_path)
    end

    it 'I cannot leave search field blank', :vcr do
      fill_in 'search', with: ''
      click_button 'Find Movies'

      expect(current_path).to eq(users_discover_path)
      expect(page).to have_content('Search Field Cannot be Blank')
    end
  end
end