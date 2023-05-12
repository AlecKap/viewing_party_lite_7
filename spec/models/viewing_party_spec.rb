require 'rails_helper'

RSpec.describe ViewingParty, type: :model do
  describe 'relationships' do
    it { should have_many :user_viewing_parties }
    it { should have_many(:users).through(:user_viewing_parties) }
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
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      @user2 = User.create!(name: 'Emma Watson', email: 'hermione.foreva@gmail.com')
      @user3 = User.create!(name: 'Sigmund Freud', email: 'its.all.about.mom@gmail.com')
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