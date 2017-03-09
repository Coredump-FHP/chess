class AddActivePlayerIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :active_player_id, :integer
  end
end
