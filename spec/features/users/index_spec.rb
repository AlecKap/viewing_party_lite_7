require 'rails_helper'

RSpec.describe 'landing page', type: :feature do
  before(:each) do
    @user1 = User.create!(name: 'Bob Saget', email: 'bob.saget@gmail.com', password: 'password123', password_confirmation: 'password123')
    @user2 = User.create!(name: 'Ellen Degeneres', email: 'ellen.degeneres@gmail.com', password: 'password123', password_confirmation: 'password123')

    visit root_path
  end

  describe 'As a visitor, when I visit the landing page' do
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

    it 'I do not see a Log Out button' do
      expect(page).to_not have_button('Log Out')
    end

    it 'I do not see user content' do
      expect(page).to_not have_content(@user1.name)
      expect(page).to_not have_content(@user1.email)
      expect(page).to_not have_content(@user2.email)
      expect(page).to_not have_content(@user2.email)
    end

    it "And I try to visit '/dashboard', I remain on the landing page and
      I see a message telling me that I must be logged in or
      registered to access my dashboard" do

      visit '/dashboard'

      expect(current_path).to eq(root_path)
      expect(page).to have_content('lol... nice try, but you must login to access the page you are looking for.')
    end
  end

  describe 'As a user, when I visit the landing page' do
    before :each do
      click_link 'Login as an Existing User'
      fill_in 'Email:', with: @user1.email
      fill_in 'Password:', with: 'password123'
      click_on 'Log In'
      click_link 'Landing Page'
    end

    it 'I see the title of application' do
      expect(page).to have_content('Viewing Party')
    end

    it 'I see a link to go back to the landing page' do
      expect(page).to have_link('Landing Page')

      click_link 'Landing Page'

      expect(current_path).to eq(root_path)
    end

    # it 'I see a link to go Back to the Dashboard' do
    #   expect(page).to have_link('Back to the Dashboard')

    #   click_link 'Back to the Dashboard'

    #   expect(current_path).to eq(user_path(@user1))
    # end

    it 'I do not see a button to create a new user' do
      expect(page).to_not have_link('Create New User')
    end

    it 'I do not see a link to login as an existing user' do
      expect(page).to_not have_link('Login as an Existing User')
    end

    it 'I see a button to Log Out' do
      expect(current_path).to eq(root_path)
      expect(page).to have_button('Log Out')

      click_button 'Log Out'

      expect(current_path).to eq(root_path)
      expect(page).to have_link('Create New User')
      expect(page).to have_link('Login as an Existing User')
    end

    it 'I see all registered user emails' do
      expect(page).to have_content(@user1.email)
      expect(page).to have_content(@user2.email)
    end
  end
end
