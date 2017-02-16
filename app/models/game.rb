class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true
  # Is called after  Base.save on new objects that have not been saved yet (no record exists).
  after_create :populate_game!
# How to fix messed up migrations http://stackoverflow.com/questions/20082002/migrations-are-pending-run-bin-rake-dbmigrate-rails-env-development-to-resol
  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)

  def populate_game!
    add_starting_pieces_for_color('white')
    add_starting_pieces_for_color('black')
  end

  def add_starting_pieces_for_color(color)!
    (1..8).each do |i|
      pieces << Piece.create(
        game: self,
        player: player_1,
        x_coordinate: i,
        y_coordinate: 2,
        type: 'Pawn'
      )
    end
    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 1,
      y_coordinate: 1,
      type: 'Rook'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 8,
      y_coordinate: 1,
      type: 'Rook'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 2,
      y_coordinate: 1,
      type: 'Knight'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 7,
      y_coordinate: 1,
      type: 'Knight'
    )
    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 3,
      y_coordinate: 1,
      type: 'Bishop'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 6,
      y_coordinate: 1,
      type: 'Bishop'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 4,
      y_coordinate: 1,
      type: 'Queen'
    )

    pieces << Piece.create(
      game: self,
      player: player_1,
      x_coordinate: 5,
      y_coordinate: 1,
      type: 'King'
    )
    save
    self
  end
end
