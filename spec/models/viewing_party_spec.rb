require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:users).through(:user_viewing_parties) }
  end

  describe 'instance methods' do
    before :each do
      @user1 = User.create!(name: 'Reid', email: 'reid@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user2 = User.create!(name: 'Jiminy Cricket', email: 'jim.cricket@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user3 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
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
    end

    describe '#host_check' do
      it 'returns the host/invited status' do
        expect(@viewing_party1.host_check(@user1.id)).to eq('The Host')
        expect(@viewing_party1.host_check(@user2.id)).to eq('Invited')
      end
    end
  end

  describe 'validations' do
    it { should validate_presence_of :movie_id }
    it { should validate_presence_of :movie_title }
    it { should validate_presence_of :movie_runtime }
    it { should validate_numericality_of :movie_id }
    it { should validate_presence_of :duration }
    it { should validate_numericality_of :duration }
    it { should validate_presence_of :day }
    it { should validate_presence_of :start_time }
    it { should validate_presence_of :host }
    it { should validate_numericality_of :host }
  end

  describe 'instance_methods' do
    before(:each) do
      @user1 = User.create!(name: 'Reid', email: 'reid@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user2 = User.create!(name: 'Jiminy Cricket', email: 'jim.cricket@gmail.com', password: 'password123', password_confirmation: 'password123')
      @user3 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com', password: 'password123', password_confirmation: 'password123')
      @viewing_party1 = ViewingParty.create!(
        movie_id: 123,
        movie_title: 'Fern Gully',
        movie_runtime: 120,
        duration: 122,
        day: '1234',
        start_time: '123',
        host: @user1.id
      )
      @viewing_party2 = ViewingParty.create!(
        movie_id: 123,
        movie_title: 'Fern Gully',
        movie_runtime: 120,
        duration: 118,
        day: '1234',
        start_time: '123',
        host: @user1.id
      )
      @params = {
        invited_users: ["#{@user2.id}", "#{@user3.id}"],
        user_id: @user1.id
      }
    end

    describe '#duration_check' do
      it 'can validate duration is greater than or equal to runtime' do
        expect(@viewing_party1.duration_check).to be(true)
        expect(@viewing_party2.duration_check).to be(false)
      end
    end

    describe '#create_user_viewing_parties' do
      it 'can create all associated user viewing parties' do
        @viewing_party1.create_user_viewing_parties(@params)
        expect(UserViewingParty.all.count).to eq(3)
      end
    end
  end
end
