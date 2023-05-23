require 'rails_helper'

RSpec.describe 'New Viewing Party Page', type: :feature do
  describe 'As a user, when I visit the new viewing party page', :vcr do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user2 = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user3 = User.create!(name: 'Sigmund Freud', email: 'its.all.about.mom@gmail.com', password: 'password123', password_confirmation: 'password123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
      visit users_discover_path
      fill_in 'search', with: 'Scott Pilgrim vs. the World'
      click_button 'Find Movies'
      click_link 'Scott Pilgrim vs. the World'
      click_button 'Create Viewing Party for Scott Pilgrim vs. the World'
    end

    it 'I see the movie title and a form to create new party', :vcr do
      within('.create_viewing_party') do
        expect(page).to have_content('Movie Title: Scott Pilgrim vs. the World')
        expect(page).to have_content('Duration of Party:')
        expect(page).to have_field('viewing_party[duration]', with: 112)
        expect(page).to have_content('Day:')
        expect(page).to have_field('viewing_party[day]')
        expect(page).to have_content('Start Time:')
        expect(page).to have_css('.start_time')
        expect(page).to have_content('Invite Other Users')

        within("#invite_user_#{@user2.id}") do
          expect(page).to have_unchecked_field('invited_users[]')
          expect(page).to have_content('Emma Watson, hermione.foreva@gmail.com')
        end

        within("#invite_user_#{@user3.id}") do
          expect(page).to have_unchecked_field('invited_users[]')
          expect(page).to have_content('Sigmund Freud, its.all.about.mom@gmail.com')
        end

        expect(page).to_not have_css("#invite_user_#{@user1.id}")
        expect(page).to have_button('Create Party')
      end
    end

    it 'I can fill out form and a new viewing party is created', :vcr do
      fill_in 'viewing_party[duration]', with: 140
      fill_in 'viewing_party[day]', with: '07/02/2023'
      fill_in 'viewing_party[start_time]', with: '0700PM'

      within("#invite_user_#{@user2.id}") do
        check 'invited_users[]'
      end

      within("#invite_user_#{@user3.id}") do
        check 'invited_users[]'
      end

      click_button 'Create Party'

      expect(current_path).to eq(dashboard_path)
      # expect(page).to have_content('Scott Pilgrim vs. the World')
    end

    it 'I cant fill it out with a duration less than the movie runtime', :vcr do
      fill_in 'viewing_party[duration]', with: 50
      fill_in 'viewing_party[day]', with: '07/02/2023'
      fill_in 'viewing_party[start_time]', with: '0700PM'

      within("#invite_user_#{@user2.id}") do
        check 'invited_users[]'
      end

      within("#invite_user_#{@user3.id}") do
        check 'invited_users[]'
      end

      click_button 'Create Party'

      expect(page).to have_content('All fields must be filled in and duration must be greater than movie runtime')
      expect(page).to have_content('Create a Movie Party for Scott Pilgrim vs. the World')
    end
  end
end