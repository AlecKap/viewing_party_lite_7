require 'rails_helper'

RSpec.describe 'user registration page', type: :feature do
  describe 'As a user when I visit the /register path' do
    it 'I see a form to input new user information' do
      visit register_path

      expect(page).to have_content('Register New User')
      expect(page).to have_content('Name:')
      expect(page).to have_field('user[name]')
      expect(page).to have_content('Email:')
      expect(page).to have_field('user[email]')
      expect(page).to have_button('Register User')

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: 'password123'
      fill_in 'Password Confirmation:', with: 'password123'

      click_button 'Register User'

      expect(page).to have_content("Rebecca Black's Dashboard")
    end

    it 'will only accept unique emails' do
      @user3 = User.create!(name: 'Rebecca Black',
                            email: 'rebecca.black@gmail.com',
                            password: 'password123',
                            password_confirmation: 'password123')

      visit register_path

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: 'password123'
      fill_in 'Password Confirmation:', with: 'password123'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end
  end
end