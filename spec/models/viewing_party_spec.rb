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
    describe '#duration_check' do
      before(:each) do
        @viewing_party1 = ViewingParty.create!(
          movie_id: 123,
          movie_title: 'Fern Gully',
          movie_runtime: 120,
          duration: 122,
          day: '1234',
          start_time: '123',
          host: 12
        )
        @viewing_party2 = ViewingParty.create!(
          movie_id: 123,
          movie_title: 'Fern Gully',
          movie_runtime: 120,
          duration: 118,
          day: '1234',
          start_time: '123',
          host: 12
        )
      end

      it 'can validate duration is greater than or equal to runtime' do
        expect(@viewing_party1.duration_check).to be(true)
        expect(@viewing_party2.duration_check).to be(false)
      end
    end
  end

  describe 'class methods' do
    
  end
end