require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  describe 'As a user, when I visit the landing page' do
    before(:each) do
      @user1 = User.create!(name: 'Bob Saget', email: 'bob.saget@gmail.com')
      @user2 = User.create!(name: 'Ellen Degeneres', email: 'ellen.degeneres@gmail.com')

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

    it 'I see a list of existing users which each link to user dashboard' do
      within('div#user_list') do
        expect(page).to have_content('All Users:')
        expect(page).to have_link(@user1.name)
        expect(page).to have_link(@user2.name)

        click_link @user1.name
        expect(current_path).to eq(user_path(@user1))
      end

      visit root_path

      within('div#user_list') do
        click_link @user2.name
        expect(current_path).to eq(user_path(@user2))
      end
    end

    it 'I see a link to go back to the landing page' do
      expect(page).to have_link('Landing Page')

      click_link 'Landing Page'

      expect(current_path).to eq(root_path)
    end
  end
end