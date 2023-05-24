require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  describe 'As a user, when I visit a movies detail page', :vcr do
    before :each do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
      visit users_discover_path
      fill_in 'search', with: 'Harry Potter and the Goblet of Fire'
      click_button 'Find Movies'
      click_link 'Harry Potter and the Goblet of Fire'
    end

    describe 'movie details page', :vcr do
      it 'has a Discover Page button' do
        expect(page).to have_button('Discover Page')

        click_button 'Discover Page'

        expect(current_path).to eq(users_discover_path)
      end

      it 'has a Create Viewing Party button' do
        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
        expect(page).to have_button('Create Viewing Party for Harry Potter and the Goblet of Fire')

        click_button 'Create Viewing Party for Harry Potter and the Goblet of Fire'

        expect(current_path).to eq(new_movie_viewing_party_path(674))
        expect(page).to have_content('Create a Movie Party for Harry Potter and the Goblet of Fire')
      end

      it 'has movie details' do
        expect(page).to have_css('.title')
        expect(page).to have_css('.vote_average')
        expect(page).to have_css('.runtime')
        expect(page).to have_css('.genre')
        expect(page).to have_css('.summary')
        expect(page).to have_css('.cast')
        expect(page).to have_css('.reviews')
        expect(page).to have_css('.total_reviews')
      end

      it 'has a summary, cast, and reviews' do
        expect(page).to have_content('Summary:')
        expect(page).to have_content('Cast:')
        expect(page).to have_content('Reviews:')
      end
    end

    describe 'sad path' do
      it "and I click the button to create a viewing party I'm redirected to
        the movies show page, and a message appears to let me know
        I must be logged in or registered to create a movie party." do
        click_button 'Create Viewing Party for Harry Potter and the Goblet of Fire'

        expect(current_path).to eq(movie_path(674))
      end
    end
  end
end
