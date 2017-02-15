class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true
  # Is called after  Base.save on new objects that have not been saved yet (no record exists).
  after_create :add_white_starting_pieces!
  after_create :add_black_starting_pieces!
  # How to fix messed up migrations http://stackoverflow.com/questions/20082002/migrations-are-pending-run-bin-rake-dbmigrate-rails-env-development-to-resol
  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def add_white_starting_pieces!
    # ----------ADD STARTING WHITE PIECES---------------
    (1..8).each do |i|
      pieces << Piece.create(
        game: self,
        player: player_1,
        color: 'white',
        x_coordinate: i,
        y_coordinate: 2,
        type: 'p'
      )
    end
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 1,
      y_coordinate: 1,
      type: 'R'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 8,
      y_coordinate: 1,
      type: 'R'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 2,
      y_coordinate: 1,
      type: 'N'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 7,
      y_coordinate: 1,
      type: 'N'
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 3,
      y_coordinate: 1,
      type: 'B'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 6,
      y_coordinate: 1,
      type: 'B'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 4,
      y_coordinate: 1,
      type: 'Q'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      color: 'white',
      x_coordinate: 5,
      y_coordinate: 1,
      type: 'K'
    )
  end

  # ----------ADD STARTING BLACK PIECES---------------
  def add_black_starting_pieces!
    (1..8).each do |i|
      pieces << Piece.create(
        game: self,
        player: player_2,
        color: 'black',
        x_coordinate: i,
        y_coordinate: 7,
        type: 'p'
      )
    end

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 1,
      y_coordinate: 8,
      type: 'R'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 8,
      y_coordinate: 8,
      type: 'R'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 7,
      y_coordinate: 8,
      type: 'N'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 2,
      y_coordinate: 8,
      type: 'N'
    )
    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 6,
      y_coordinate: 8,
      type: 'B'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 3,
      y_coordinate: 8,
      type: 'B'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 4,
      y_coordinate: 8,
      type: 'Q'
    )

    pieces << Piece.create(
      game: self,
      player: player_2,
      color: 'black',
      x_coordinate: 5,
      y_coordinate: 8,
      type: 'K'
    )
    save
    self
  end
end
