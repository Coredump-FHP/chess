class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true
  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def populate_game!
    # white player
    (1..8).each do |i|
      pieces << Piece.create(
        game: self,
        player: player_1,
        color: 'white',
        x_coordinate: i,
        y_coordinate: 2,
        type: 'Pawn',
        captured: false
      )
    end
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 1,
      y_coordinate: 1,
      type: 'Rook',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 2,
      y_coordinate: 1,
      type: 'Knight',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 3,
      y_coordinate: 1,
      type: 'Bishop',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 4,
      y_coordinate: 1,
      type: 'Queen',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 5,
      y_coordinate: 1,
      type: 'King',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 6,
      y_coordinate: 1,
      type: 'Bishop',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 7,
      y_coordinate: 1,
      type: 'Knight',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 8,
      y_coordinate: 1,
      type: 'Rook',
      captured: false
    )
    # black player
    (1..8).each do |i|
      pieces << Piece.create(
        game: self,
        player: player_2,
        color: 'black',
        x_coordinate: i,
        y_coordinate: 7,
        type: 'Pawn',
        captured: false
      )
    end
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 1,
      y_coordinate: 8,
      type: 'Rook',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 2,
      y_coordinate: 8,
      type: 'Knight',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 3,
      y_coordinate: 8,
      type: 'Bishop',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 4,
      y_coordinate: 8,
      type: 'Queen',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 5,
      y_coordinate: 8,
      type: 'King',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 6,
      y_coordinate: 8,
      type: 'Bishop',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 7,
      y_coordinate: 8,
      type: 'Knight',
      captured: false
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 8,
      y_coordinate: 8,
      type: 'Rook',
      captured: false
    )
    save
    self
  end
end
