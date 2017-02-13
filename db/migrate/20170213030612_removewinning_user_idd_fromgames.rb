class RemovewinningUserIddFromgames < ActiveRecord::Migration[5.0]
  def up
    remove_column :games, :winning_user_id
  end
end
