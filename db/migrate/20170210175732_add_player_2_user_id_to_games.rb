class AddPlayer2UserIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :player_2_user_id, :integer
  end
end
