# noinspection ALL
class Game < ApplicationRecord
  validates :name, presence: true, length: { minimum: 1 }
  has_many :pieces
  belongs_to :player_1, class_name: 'Player', optional: true
  belongs_to :player_2, class_name: 'Player', optional: true
  belongs_to :winning_player, class_name: 'Player', optional: true
  belongs_to :active_player, class_name: 'Player', optional: true

  scope :available, lambda {
                      where('player_1_id IS NOT NULL AND player_2_id IS NULL')
                        .or(Game.where('player_1_id IS NULL AND player_2_id IS NOT NULL'))
                    }

  def retrieve_piece(x, y)
    pieces.find_by(x_coordinate: x, y_coordinate: y)
  end

  def render_piece(x, y)
    piece = retrieve_piece(x, y)
    return nil if piece.nil?
    piece.icon
  end

  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def populate_game!
    return unless pieces.count.zero?
    add_starting_pieces_for_color!('white')
    add_starting_pieces_for_color!('black')
    save
  end

  def check?
    white_king = pieces.find_by(type: 'King', color: 'white')
    black_pieces = pieces.where(color: 'black')

    black_pieces.each { |black_piece| return true if black_piece.valid_move?(white_king.x_coordinate, white_king.y_coordinate) }

    black_king = pieces.find_by(type: 'King', color: 'black')
    white_pieces = pieces.where(color: 'white')

    white_pieces.each { |white_piece| return true if white_piece.valid_move?(black_king.x_coordinate, black_king.y_coordinate) }

    false
  end

  def inactive_player
    return player_1_id if turn == player_2_id
    return player_2_id if turn == player_1_id
  end

  def not_your_turn
    !inactive_player
  end

  # Stalemate is when the King is NOT in check, and has no valid moves (ie - any move they make puts them into check)
  # Step 1 - determine if the king is in check.  If true - return stalemate as FALSE.
  # Step 2 - determine if the king has a valid_move && if it puts him into check, stalemate returns TRUE.
  # Step 3 - determine if the king has any available moves that does not put them into check, stalemate is FALSE

  def stalemate?
    #   white_king = pieces.find_by(type: 'King', color: 'white')
    # if white_king.check?
    #    return false
    # end
    # if white_king.valid_move? && !game.check?
    #   return false
    # end
    # true
  end

  def draw
    stalemate?
  end

  private

  def add_starting_pieces_for_color!(color)
    if color == 'white'
      king_row = 0
      pawn_row = 1
    else
      king_row = 7
      pawn_row = 6
    end

    (0..7).each do |i|
      create_piece!(color, i, pawn_row, 'Pawn', "pawn-#{color}.png")
    end
    create_piece!(color, 0, king_row, 'Rook', "rook-#{color}.png")
    create_piece!(color, 1, king_row, 'Knight', "knight-#{color}.png")
    create_piece!(color, 2, king_row, 'Bishop', "bishop-#{color}.png")
    create_piece!(color, 3, king_row, 'Queen', "queen-#{color}.png")
    create_piece!(color, 4, king_row, 'King', "king-#{color}.png")
    create_piece!(color, 5, king_row, 'Bishop', "bishop-#{color}.png")
    create_piece!(color, 6, king_row, 'Knight', "knight-#{color}.png")
    create_piece!(color, 7, king_row, 'Rook', "rook-#{color}.png")
  end

  def create_piece!(color, row, col, piece, icon)
    pieces << Piece.create(
      game: self,
      player: color == 'white' ? player_1 : player_2,
      color: color == 'white' ? 0 : 1,
      x_coordinate: row,
      y_coordinate: col,
      type: piece,
      icon: icon,
      captured: false
    )
  end
end
