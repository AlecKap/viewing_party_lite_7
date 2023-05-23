require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  describe 'As a user, when I visit the landing page' do
    before(:each) do
      @user1 = User.create!(name: 'Bob Saget', email: 'bob.saget@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user2 = User.create!(name: 'Ellen Degeneres', email: 'ellen.degeneres@gmail.com', password: 'password123', password_confirmation: 'password123')

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

    it 'I see a link to login as an existing user' do
      expect(page).to have_link('Login as an Existing User')

      click_link 'Login as an Existing User'

      expect(current_path).to eq(login_path)
    end

    it 'I see a link to go back to the landing page' do
      expect(page).to have_link('Landing Page')

      click_link 'Landing Page'

      expect(current_path).to eq(root_path)
    end
  end
end
