require 'rails_helper'

RSpec.describe 'User Dsahboard Page' do
  describe 'When I visit the users show page' do
    before :each do
      @user1 = User.create!(name: 'Reid', email: 'reid@gmail.com')
      @user2 = User.create!(name: 'Jiminy Cricket', email: 'jim.cricket@gmail.com')
      @user3 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      @viewing_party1 = ViewingParty.create!(movie_title: 'Selena',
                                             duration: 180,
                                             day: '09/28/2023',
                                             start_time: '6:30pm',
                                             host: @user1.id,
                                             movie_id: 16052,
                                             movie_runtime: 127)
      @viewing_party2 = ViewingParty.create!(movie_title: 'Dumbo',
                                             duration: 90,
                                             day: '07/17/2023',
                                             start_time: '4:30pm',
                                             host: @user2.id,
                                             movie_id: 11360,
                                             movie_runtime: 64)
      @viewing_party3 = ViewingParty.create!(movie_title: 'Miracle',
                                             duration: 150,
                                             day: '05/13/2023',
                                             start_time: '7:30pm',
                                             host: @user2.id,
                                             movie_id: 14292,
                                             movie_runtime: 135)
      UserViewingParty.create!(user: @user1, viewing_party: @viewing_party1)
      UserViewingParty.create!(user: @user1, viewing_party: @viewing_party2)
      UserViewingParty.create!(user: @user2, viewing_party: @viewing_party1)
      UserViewingParty.create!(user: @user2, viewing_party: @viewing_party2)
      UserViewingParty.create!(user: @user3, viewing_party: @viewing_party1)
      visit user_path(@user1)
    end

    it 'I see the name of the user', :vcr do
      expect(page).to have_content(@user1.name)
    end

    describe 'I see a discover movies button' do
      it 'when I click this button I am
        redirected to the discover movies page', :vcr do
        expect(current_path).to eq(user_path(@user1))
        expect(page).to have_button('Discover Movies')

        click_button('Discover Movies')

        expect(current_path).to eq(user_discover_index_path(@user1))
        expect(page).to have_content('Discover Movies')
      end
    end

    describe 'I see a section that lists all the users veiwng parties' do
      it 'has a user_viewing_parties', :vcr do
        within '#user_viewing_parties' do
          expect(page).to have_content('My Viewing Parties')
        end
      end

      it 'has viewing parties details', :vcr do
        within ".viewing_party_#{@viewing_party1.id}" do
          expect(page).to have_css('.movie_img')
          expect(page).to have_content(@viewing_party1.movie_title)
          expect(page).to have_content(@viewing_party1.day)
          expect(page).to have_content(@viewing_party1.start_time)
          expect(page).to have_content('I am The Host')
          expect(page).to have_content(@user1.name)
          expect(page).to have_content(@user2.name)
          expect(page).to have_content(@user3.name)
          expect(page).to_not have_content(@viewing_party2.movie_title)
          expect(page).to_not have_content(@viewing_party3.movie_title)
        end

        within ".viewing_party_#{@viewing_party2.id}" do
          expect(page).to have_css('.movie_img')
          expect(page).to have_content(@viewing_party2.movie_title)
          expect(page).to have_content(@viewing_party2.day)
          expect(page).to have_content(@viewing_party2.start_time)
          expect(page).to have_content('I am Invited')
          expect(page).to have_content(@user1.name)
          expect(page).to have_content(@user2.name)
          expect(page).to_not have_content(@user3.name)
          expect(page).to_not have_content(@viewing_party1.movie_title)
          expect(page).to_not have_content(@viewing_party3.movie_title)
        end

        expect(page).to_not have_content(@viewing_party3.movie_title)
        expect(page).to_not have_content(@viewing_party3.day)
        expect(page).to_not have_content(@viewing_party3.start_time)
      end

      it 'has title of movie as a link to that movies show page', :vcr do
        within ".viewing_party_#{@viewing_party1.id}" do
          expect(page).to have_link('Selena')

          click_link 'Selena'

          expect(current_path).to eq(user_movie_path(@user1, 16052))
        end

        visit user_path(@user1)

        within ".viewing_party_#{@viewing_party2.id}" do
          expect(page).to have_link('Dumbo')

          click_link 'Dumbo'

          expect(current_path).to eq(user_movie_path(@user1, 11360))
        end
      end
    end
  end
end
