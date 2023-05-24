require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  describe 'As a user, when I visit the landing page' do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'FRIDAY4eva', password_confirmation: 'FRIDAY4eva')
      @user2 = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com', password: 'password123', password_confirmation: 'password123')

      visit root_path
    end

    it 'I see the title of application' do
      expect(page).to have_content('Viewing Party')
    end

    it 'I see a button to create a new user' do
      expect(page).to have_link('Create New User')

      click_link 'Create New User'

      expect(current_path).to eq(register_path)
    end

    it 'I see a link to log in to a user account' do
      expect(page).to have_link('Login')

      click_link 'Login'

      expect(current_path).to eq(login_path)
    end

    it 'I see a list of existing users which each link to user dashboard if I am logged in as a user' do
      expect(page).to_not have_content('All Users:')
      expect(page).to_not have_content(@user1.name)
      expect(page).to_not have_content(@user2.name)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)

      visit root_path

      within('.user_list') do
        expect(page).to have_content('All Users:')
        expect(page).to have_content(@user1.name)
        expect(page).to have_content(@user2.name)
      end
    end

    it 'I see a link to go back to the landing page' do
      expect(page).to have_link('Landing Page')

      click_link 'Landing Page'

      expect(current_path).to eq(root_path)
    end

    xit 'if I try to visit dashboard without first being logged in I remain on landing page with a message' do
      visit user_path(@user1)

      expect(current_path).to eq(root_path)
      expect(page).to have_content('You must be logged in or register to view this page')
    end
  end
end