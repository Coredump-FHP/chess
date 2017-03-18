class AddPlayerTurnToPlayers < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :player_turn, :integer
  end
end
