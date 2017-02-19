class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true


  scope :available, lambda {
                      where('player_1_id IS NOT NULL AND player_2_id IS NULL')
                        .or(Game.where('player_1_id IS NULL AND player_2_id IS NOT NULL'))
                    }

  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def populate_game!
    add_starting_pieces_for_color!('white')
    add_starting_pieces_for_color!('black')
    save
    self
  end

  private

  def add_starting_pieces_for_color!(color)
    if color == 'white'
      king_row = 1
      pawn_row = 2
    else
      king_row = 8
      pawn_row = 7
    end

    (1..8).each do |i|
      create_piece!(color, i, pawn_row, 'Pawn')
    end
    create_piece!(color, 1, king_row, 'Rook')
    create_piece!(color, 2, king_row, 'Knight')
    create_piece!(color, 3, king_row, 'Bishop')
    create_piece!(color, 4, king_row, 'Queen')
    create_piece!(color, 5, king_row, 'King')
    create_piece!(color, 6, king_row, 'Bishop')
    create_piece!(color, 7, king_row, 'Knight')
    create_piece!(color, 8, king_row, 'Rook')
  end

  def create_piece!(color, row, col, piece)
    pieces << Piece.create(
      game: self,
      player: color == 'white' ? player_1 : player_2,
      color: color == 'white' ? 0 : 1,
      x_coordinate: row,
      y_coordinate: col,
      type: piece,
      captured: false
    )
  end

end
