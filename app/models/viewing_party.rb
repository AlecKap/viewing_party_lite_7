class ViewingParty < ApplicationRecord
  has_many :user_viewing_parties
  has_many :users, through: :user_viewing_parties

  def host_check(user_id)
    if self.host == user_id
      'The Host'
    else
      'Invited'
    end
  end
end