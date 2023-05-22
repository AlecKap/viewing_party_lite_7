require 'rails_helper'

RSpec.describe 'user registration page', type: :feature do
  describe 'As a user when I visit the /register path' do
    before :each do
      visit register_path
    end
    it 'I see a form to input new user information' do
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

      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: 'password123'
      fill_in 'Password Confirmation:', with: 'password123'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content('Email has already been taken')
    end

    it 'cannot leave password blank' do
      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: ''
      fill_in 'Password Confirmation:', with: 'password123'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password can't be blank")
    end

    it 'cannot leave password confirmation blank' do
      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: 'password123'
      fill_in 'Password Confirmation:', with: ''
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end

    it 'password and password confirmation must match' do
      fill_in 'user[name]', with: 'Rebecca Black'
      fill_in 'user[email]', with: 'rebecca.black@gmail.com'
      fill_in 'Password:', with: 'password123'
      fill_in 'Password Confirmation:', with: 'Password123'
      click_button 'Register User'

      expect(current_path).to eq(register_path)
      expect(page).to have_content("Password confirmation doesn't match Password")
    end
  end
end
