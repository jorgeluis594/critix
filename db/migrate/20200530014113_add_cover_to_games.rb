class AddCoverToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :cover, :string
  end
end
