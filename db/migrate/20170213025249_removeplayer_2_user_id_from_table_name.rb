class Removeplayer2UserIdFromTableName < ActiveRecord::Migration[5.0]
  def up
    remove_column :games, :player_2_user_id
  end

  def down
    add_column :games, :player_2_id, :integer
  end
end
