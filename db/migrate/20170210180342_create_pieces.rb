class CreatePieces < ActiveRecord::Migration[5.0]
  def change
    create_table :pieces do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :color
      t.integer :x_coordinate
      t.integer :y_coordinate
      t.string  :type
      t.boolean :captured, :default => false
      t.timestamps
    end
  end
end
