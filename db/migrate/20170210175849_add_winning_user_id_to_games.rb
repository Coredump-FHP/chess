class AddWinningUserIdToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :winning_user_id, :integer
  end
end
