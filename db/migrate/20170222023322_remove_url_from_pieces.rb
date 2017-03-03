class RemoveUrlFromPieces < ActiveRecord::Migration[5.0]
  def up
    remove_column :pieces, :url
  end
end
