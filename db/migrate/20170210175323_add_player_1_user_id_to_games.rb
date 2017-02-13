class AddPlayer1UserIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player_1_user_id, :integer
  end
end
