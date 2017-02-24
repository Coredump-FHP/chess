class AddUrlToPieces < ActiveRecord::Migration[5.0]
  def change
    add_column :pieces, :url, :string
  end
end
