require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  describe 'As a user, when I visit the new viewing party page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      @user2 = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com')
      @user3 = User.create!(name: 'Sigmund Freud', email: 'its.all.about.mom@gmail.com')
      visit user_discover_index_path(@user1)
      fill_in 'search', with: 'Scott Pilgrim vs. the World'
      click_button 'Find Movies'
      click_link 'Scott Pilgrim vs. the World'
      click_button 'Create Viewing Party for Scott Pilgrim vs. the World'
    end

    it 'I see the movie title and a form to create new party', :vcr do
      within('.create_viewing_party') do
        expect(page).to have_content('Movie Title: Scott Pilgrim vs. the World')
        expect(page).to have_content('Duration of Party:')
        expect(page).to have_field('duration', value: 112)
        expect(page).to have_content('Day: ')
        expect(page).to have_field('day')
        expect(page).to have_content('Start Time:')
        expect(page).to have_field('start_time')
        expect(page).to have_content('Invite Other Users')
        expect(page).to have_button('Create Party')
      end
    end

    it 'I see all a checkbox list of all users', :vcr do
      within('.invite_other_users') do
        expect(page).to have_content
      end
    end

    it 'I can fill out form and a new viewing party is created', :vcr do

    end
  end
end