class AddIconToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :icon, :string
  end
end
