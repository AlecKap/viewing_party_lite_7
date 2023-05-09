class CreateViewingParties < ActiveRecord::Migration[7.0]
  def change
    create_table :viewing_parties do |t|
      t.string :movie_title
      t.integer :duration
      t.string :day
      t.string :start_time

      t.timestamps
    end
  end
end
