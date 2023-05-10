require 'rails_helper'

RSpec.describe 'User Dsahboard Page' do
  describe 'When I visit the users show page' do
    before :each do
      @user1 = User.create!(name: 'Reid', email: 'reid@gmail.com')
      visit user_path(@user1)
    end

    it 'I see the name of the user' do
      expect(page).to have_content(@user1.name)
    end

    describe 'I see a discover movies button' do
      it 'when I click this button I am
        redirected to the discover movies page' do
        expect(current_path).to eq(user_path(@user1))
        expect(page).to have_button('Discover Movies')
        
        click_button('Discover Movies')

        expect(current_path).to eq(user_discover_path(@user1))
        expect(page).to have_content('Discover Movies')
      end
    end

    it 'I see a section that lists all the users veiwng parties' do
      within '#user_viewing_parties' do
        expect(page).to have_content('My Viewing Parties')
      end
    end
  end
end