require 'rails_helper'

RSpec.describe 'User can log out' do
  describe 'As a logged in user, when I visit the landing page' do
    before(:each) do
      user = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'FRIDAY4eva', password_confirmation: 'FRIDAY4eva')
      visit login_path

      fill_in :name, with: user.name
      fill_in :password, with: user.password

      click_on "Log In"

      visit root_path
    end

    it 'I no longer see a link to login or register but I see a link to log out' do
      expect(page).to have_link('Log Out')
      expect(page).to_not have_link('Login')
      expect(page).to_not have_link('Create New User')
    end

    it 'when I click the log out link I am redirected to the landing page and I see a login link again' do
      click_link 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Login')
      expect(page).to have_link('Create New User')
    end
  end
end