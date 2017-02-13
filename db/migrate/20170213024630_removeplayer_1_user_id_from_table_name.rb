class Removeplayer1UserIdFromTableName < ActiveRecord::Migration[5.0]
  def up
    remove_column :games, :player_1_user_id
  end

  def down
    add_column :games, :player_1_id, :integer
  end
end
