class AddWinningPlayerIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :winning_player_id, :integer
  end
end
