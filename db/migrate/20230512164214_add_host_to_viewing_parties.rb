class AddHostToViewingParties < ActiveRecord::Migration[7.0]
  def change
    add_column :viewing_parties, :host, :integer
  end
end
