class RemovePlayerTurnFromPlayers < ActiveRecord::Migration[5.0]
  def up
    remove_column :players, :player_turn
  end
end
