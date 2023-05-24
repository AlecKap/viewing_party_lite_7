require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  describe 'As a user when I visit the discover movies page' do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'FRIDAY4eva', password_confirmation: 'FRIDAY4eva')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit discover_index_path
    end

    describe 'and click on the Top Movies button', :vcr do
      before(:each) do
        click_link 'Find Top Rated Movies'
      end

      it 'I see a link to go back to discover page' do
        expect(current_path).to eq(movies_path)
        expect(page).to have_link('Discover Page')

        click_link 'Discover Page'
        expect(current_path).to eq(discover_index_path)
      end

      it 'contains a list of 20 top movies' do
        expect(page).to have_css('.movie', count: 20)

        within(first('.movie')) do
          expect(page).to have_css('.title')
          expect(page).to have_css('.vote_average')
        end
      end
    end

    describe 'and fill in the search box', :vcr do
      it 'with a reasonable search, I see up to 20 results listed' do
        fill_in 'search', with: 'lion'
        click_button 'Find Movies'

        expect(current_path).to eq(movies_path)
        within(first('.movie')) do
          expect(page).to have_content(/lion/i)
          expect(page).to have_css('.title')
          expect(page).to have_css('.vote_average')
        end
      end

      it 'each movie has a link to its detail page', :vcr do
        visit discover_index_path
        fill_in 'search', with: 'Harry Potter and the Goblet of Fire'
        click_button 'Find Movies'
        click_link 'Harry Potter and the Goblet of Fire'

        expect(page).to have_content('Movie Details Page')
      end
    end
  end
end