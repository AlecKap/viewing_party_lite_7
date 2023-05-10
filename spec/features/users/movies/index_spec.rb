require 'rails_helper'

RSpec.describe 'Movies Results Page', type: :feature do
  describe 'As a user when I visit the discover movies page' do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      visit user_discover_index_path(@user1)
    end

    describe 'and click on the Top Movies button', :vcr do
      before(:each) do
        click_link 'Find Top Rated Movies'
      end

      it 'I see a link to go back to discover page' do
        expect(current_path).to eq(user_movies_path(@user1))
        expect(page).to have_link('Discover Page')

        click_link 'Discover Page'
        expect(current_path).to eq(user_discover_index_path(@user1))
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
      before(:each) do
        visit
      end
    end
  end
end