require 'rails_helper'

RSpec.describe 'Logging In' do
  before :each do
    @user = User.create(name: 'Joe Thornton', email: 'JumboJoe19@gmail.com', password: 'password123')
    visit login_path
  end

  it 'can log in with valid credentials' do
    expect(current_path).to eq(login_path)

    fill_in 'Email:', with: @user.email
    fill_in 'Password:', with: @user.password

    click_on 'Log In'

    expect(current_path).to eq(user_path(@user))
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
