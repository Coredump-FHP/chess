class Piece < ApplicationRecord
  belongs_to :player
  belongs_to :game


  # We will need a way to know which pieces
  # will subclass the Piece model
  def self.type
    %w(Pawn King Queen Rook Knight Bishop)
  end
end
