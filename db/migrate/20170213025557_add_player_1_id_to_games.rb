class AddPlayer1IdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player_1_id, :integer
  end
end
