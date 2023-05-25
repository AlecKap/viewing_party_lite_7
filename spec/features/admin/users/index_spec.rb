require 'rails_helper'

RSpec.describe 'Admin users index page' do
  describe 'As an admin, when I visit the admin users index page' do
    before :each do
      @user1 = User.create!(name: 'Bob Saget',
                            email: 'bob.saget@gmail.com',
                            password: 'password123',
                            password_confirmation: 'password123')
      @user2 = User.create!(name: 'Ellen Degeneres',
                            email: 'ellen.degeneres@gmail.com',
                            password: 'password123',
                            password_confirmation: 'password123')
      @admin = User.create!(name: 'Admin',
                            email: 'Admin@gmail.com',
                            password: '1234',
                            role: 1)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
      visit admin_users_path
    end

    it 'I see a list of all the default users email addresses
      which are links to that prticular users show page' do
      expect(page).to have_link('bob.saget@gmail.com')
      expect(page).to have_link('ellen.degeneres@gmail.com')
      expect(page).to_not have_link('Admin@gmail.com')

      click_link 'bob.saget@gmail.com'

      expect(current_path).to eq(admin_path(@user1))
      expect(page).to have_content("#{@user1.name}'s Dashboard")
    end
  end

  describe 'as default user' do
    it 'I do not have access to the admin dashboard index' do
      user1 = User.create!(name: 'Bob Saget',
                           email: 'bob.saget@gmail.com',
                           password: 'password123',
                           password_confirmation: 'password123')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)
      visit admin_users_path

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
