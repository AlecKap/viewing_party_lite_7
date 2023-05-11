require 'rails_helper'

RSpec.describe 'Movie Details Page', type: :feature do
  describe 'As a user, when I visit a movies detail page' do
    before(:each) do
      @user1 = User.create!(name: 'Rebecca Black', email: 'rebecca.black@gmail.com')
      
    end
  end
end