require 'rails_helper'

RSpec.describe 'Logging In' do
  describe 'as a user' do
    before :each do
      @user = User.create(name: 'Joe Thornton', email: 'JumboJoe19@gmail.com', password: 'password123')
      visit login_path
    end

    it 'can log in with valid credentials' do
      expect(current_path).to eq(login_path)

      fill_in 'Email:', with: @user.email
      fill_in 'Password:', with: @user.password

      click_on 'Log In'

      expect(current_path).to eq(dashboard_path)
    end

    it 'cannot log in with a non existant email' do
      fill_in 'Email:', with: 'halie@gmail.com'
      fill_in 'Password:', with: 'Password123'
      click_on 'Log In'

      expect(current_path).to eq(login_path)

      expect(page).to have_content('Sorry, these are not valid credentials. Please try again.')
    end

    it 'cannot log in with invalid password' do
      fill_in 'Email:', with: @user.email
      fill_in 'Password:', with: 'Password123'
      click_on 'Log In'

      expect(current_path).to eq(login_path)

      expect(page).to have_content('Sorry, these are not valid credentials. Please try again.')
    end
  end

  describe 'as an Admin' do
    it 'can log in with valid credentials' do
      admin = User.create(name: 'Admin',
                          email: 'Admin@gmail.com',
                          password: '1234',
                          role: 1)
      visit login_path
      expect(current_path).to eq(login_path)

      fill_in 'Email:', with: admin.email
      fill_in 'Password:', with: admin.password

      click_on 'Log In'

      expect(current_path).to eq(admin_users_path)
    end
  end
end
