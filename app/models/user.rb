class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties
  
end