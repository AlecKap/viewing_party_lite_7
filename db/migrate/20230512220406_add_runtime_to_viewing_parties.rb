class AddRuntimeToViewingParties < ActiveRecord::Migration[7.0]
  def change
    add_column :viewing_parties, :movie_runtime, :integer
  end
end
