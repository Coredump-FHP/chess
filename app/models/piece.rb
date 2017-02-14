class Piece < ApplicationRecord
  belongs_to :player
  belongs_to :game

  self.inheritance_column = :type

  # We will need a way to know which animals
  # will subclass the Animal model
  def self.type
    %w(Pawn King Queen Rook Knight Bishop)
  end
end
