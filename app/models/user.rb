class User < ApplicationRecord
  has_many :user_viewing_parties
  has_many :viewing_parties, through: :user_viewing_parties
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
 
  has_secure_password
end
