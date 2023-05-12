require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  describe 'As a user, when I visit a movies detail page' do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      visit user_discover_index_path(@user1)

      click_link 'Find Top Rated Movies'

      link = all('.title')[0]

      link.click
    end

    it 'has a Discover Page button' do
      expect(page).to have_button('Discover Page')

      click_button 'Discover Page'

      expect(current_path).to eq(user_discover_index_path(@user1))
    end

    it 'has a Create Viewing Party button' do
      expect(page).to have_css('.create_viewing_party')

      link = find('.create_viewing_party')

      link.click

      expect(page).to have_content('Viewing Parties')
    end

    it 'has movie details' do
      expect(page).to have_css('.title')
      expect(page).to have_css('.vote_average')
      expect(page).to have_css('.runtime')
      expect(page).to have_css('.genre')
      expect(page).to have_css('.summary')
      expect(page).to have_css('.cast')
      expect(page).to have_css('.reviews')
    end
  end
end
