require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:users).through(:user_viewing_parties) }
  end

  describe 'instance methods' do
    before :each do
      @user1 = User.create!(name: 'Reid', email: 'reid@gmail.com')
      @user2 = User.create!(name: 'Jiminy Cricket', email: 'jim.cricket@gmail.com')
      @user3 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      @viewing_party1 = ViewingParty.create!(movie_title: 'Selena',
                                             duration: 127,
                                             day: '09/28/2023',
                                             start_time: '6:30pm',
                                             host: @user1.id,
                                             movie_id: 16052) # potentially string interpolate the user
      @viewing_party2 = ViewingParty.create!(movie_title: 'Dumbo',
                                             duration: 64,
                                             day: '07/17/2023',
                                             start_time: '4:30pm',
                                             host: @user2.id,
                                             movie_id: 11360)
      @viewing_party3 = ViewingParty.create!(movie_title: 'Miracle',
                                             duration: 135,
                                             day: '05/13/2023',
                                             start_time: '7:30pm',
                                             host: @user2.id,
                                             movie_id: 14292)
      UserViewingParty.create!(user: @user1, viewing_party: @viewing_party1)
      UserViewingParty.create!(user: @user1, viewing_party: @viewing_party2)
      UserViewingParty.create!(user: @user2, viewing_party: @viewing_party1)
      UserViewingParty.create!(user: @user2, viewing_party: @viewing_party2)
      UserViewingParty.create!(user: @user3, viewing_party: @viewing_party1)
    end

    describe '#host_check' do
      it 'returns the host/invited status' do
        expect(@viewing_party1.host_check(@user1.id)).to eq('The Host')
        expect(@viewing_party1.host_check(@user2.id)).to eq('Invited')
      end
    end
  end
end
