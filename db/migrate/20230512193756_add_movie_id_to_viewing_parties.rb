class AddMovieIdToViewingParties < ActiveRecord::Migration[7.0]
  def change
    add_column :viewing_parties, :movie_id, :integer
  end
end
