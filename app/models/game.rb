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

  def inactive_player
    return player_1_id if turn == player_2_id
    return player_2_id if turn == player_1_id
  end

  def not_your_turn
    !inactive_player
  end

  # Populate a game with all the pieces in the correct locations (x_coordinate, y_coordinate)
  def populate_game!
    return unless pieces.count.zero?
    add_starting_pieces_for_color!('white')
    add_starting_pieces_for_color!('black')
    save
  end

  def check?
    return true if in_check?('white')
    return true if in_check?('black')
    white_king = pieces.find_by(type: 'King', color: 'white')
    black_pieces = pieces.where(color: 'black')

    black_pieces.each { |black_piece| return true if black_piece.valid_move?(white_king.x_coordinate, white_king.y_coordinate) }

    black_king = pieces.find_by(type: 'King', color: 'black')
    white_pieces = pieces.where(color: 'white')

    white_pieces.each { |white_piece| return true if white_piece.valid_move?(black_king.x_coordinate, black_king.y_coordinate) }

    false
  end

  #-----------------------------------------------------------------------------------------------------------------------------

  # Keep track of current king.  We don't care what the other king is doing.
  def in_check?(color)
    king = pieces.find_by(type: 'King', color: color)
    opposing_pieces = pieces.where(color: king.opposite_color)

    opposing_pieces.each { |opposing_piece| return true if opposing_piece.valid_move?(king.x_coordinate, king.y_coordinate) }
    false
  end

  def in_checkmate?(color)
    #1. Get king
    checked_king = pieces.find_by(type: 'King', color: color)

    #  a. king has to be in_check
    return false unless in_check?(color)

    #  b. king cannot get out of check (has no more valid moves to get out of check)
    #     remember the king is not moving in this method, but checking if he is in checkmate
    #checked_king.valid_moves.each { 
    #  |move| return false if !in_check_if(checked_king, move.x, move.y)
    #}

    #  c. king cannot be blocked by another piece (any color)
    pieces = pieces.find_by(color: color, captured: false).each { |piece| 
      # 
      piece.valid_moves.each {
        |move| return false if !in_check_if(piece, move.x, move.y)
      }
    }

    #  e. pieces causing check cannot be captured
      # TODO: write captured


      return true
  end

  # a piece can block the king
  def can_block(king, x, y)
    #king = pieces.find_by(type: 'King', color: piece.color)
    blocking_piece = pieces.where(color: color)

    blocking_piece.each { |blocking_piece| return true if blocking_piece.obstructed?(x, y)}
    return false
  end


  # opposing pieces check if king is in_check_if it moves towards the king
  def in_check_if?(king, x, y)
    #king = pieces.find_by(type: 'King', color: piece.color)
    opposing_pieces = pieces.where(color: king.opposite_color)
    #opposing piece can move toward king to put him in check
    opposing_pieces.each { |opposing_piece| return true if opposing_piece.valid_move?(x, y) }
    false
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
