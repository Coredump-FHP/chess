class AddPlayer2IdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player_2_id, :integer
  end
end
