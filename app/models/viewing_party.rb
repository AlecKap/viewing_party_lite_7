class ViewingParty < ApplicationRecord
  validates :movie_id, presence: true, numericality: true
  validates :movie_title, presence: true
  validates :movie_runtime, presence: true, numericality: true
  validates :duration, presence: true, numericality: true
  validates :day, presence: true
  validates :start_time, presence: true
  validates :host, presence: true, numericality: true
  has_many :user_viewing_parties
  has_many :users, through: :user_viewing_parties

  def duration_check
    duration >= movie_runtime
  end
end