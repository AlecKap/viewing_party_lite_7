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
      expect(page).to have_field(:user_password)
      expect(page).to have_field(:user_password_confirmation)

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in :user_password, with: 'FRIDAY4eva'
      fill_in :user_password_confirmation, with: 'FRIDAY4eva'
      click_button 'Register User'

      expect(page).to have_content("Welcome, Rebecca Black")
      expect(page).to have_content("Rebecca Black's Dashboard")
    end

    it 'will only accept unique emails' do
      User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'FRIDAY4eva', password_confirmation: 'FRIDAY4eva')

      visit register_path

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in :user_password, with: 'FRIDAY4eva'
      fill_in :user_password_confirmation, with: 'FRIDAY4eva'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Validation failed: Email has already been taken')
    end

    it 'will not accept empty passwords' do
      visit register_path

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in :user_password, with: ''
      fill_in :user_password_confirmation, with: ''
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Validation failed: Password digest can't be blank")
    end

    it 'will not accept non-matching passwords' do
      visit register_path

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in :user_password, with: 'FRIDAY4eva'
      fill_in :user_password_confirmation, with: 'THURSDAY4eva'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Validation failed: Password confirmation doesn't match Password")
    end
  end
end