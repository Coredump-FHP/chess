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

  # Keep track of current king.  We don't care what the other king is doing.
  def check?(color)
    king = pieces.find_by(type: 'King', color: color)
    opposing_pieces = pieces.where(color: king.opposite_color, captured: false)

    opposing_pieces.each { |opposing_piece| return true if opposing_piece.valid_move?(king.x_coordinate, king.y_coordinate) }
    false
  end

  def checkmate?(color)
    #  a. king has to be in check
    return false unless check?(color)

    #  a1. king cannot get out of check (has no more valid moves to get out of check)
    #  a2. king cannot be blocked by another piece (any color)
    #  a3. pieces checking king check cannot be captured

    # Go through every possible move for every single piece I have and see if you can get out of checkmate
    pieces.where(color: color, captured: false).find_each do |piece|
      piece.valid_moves.each do |move|
        return false unless misstep?(piece, move[:x], move[:y])
      end
    end
    true
  end

  # Make the move and check to see if it was a mis step, and move back.
  def misstep?(moving_piece, move_to_x, move_to_y)
    # starting position
    x = moving_piece.x_coordinate
    y = moving_piece.y_coordinate

    # find the destination piece and hold it in memory
    captured_piece = pieces.find_by(x_coordinate: move_to_x, y_coordinate: move_to_y, captured: false)

    # find the destination piece,move
    # move to see if it puts you in check. if true, it's a misstep
    moving_piece.move_to!(move_to_x, move_to_y)
    misstep = check?(moving_piece.color)

    # move it back to starting position (undo move)
    moving_piece.move_to!(x, y)

    # if there is a piece in the destination, take the piece and set to not captured and put back x y coordinates
    # (an undo - put pieces back to original location if pieces are eaten)
    captured_piece.update_attributes(x_coordinate: move_to_x, y_coordinate: move_to_y, captured: false) if captured_piece

    misstep
  end

  # Stalemate is when the King is NOT in check, and the only move they have puts them into check)
  # Step 1 - determine if the king is in check.
  # Step 2 - determine if the king has a valid_move && if it puts him into check, stalemate returns TRUE.
  # Step 3 - determine if the king has any available moves that does not put them into check, stalemate is FALSE

  def stalemate?
    return true if !check? && king_moves_into_check
    false
  end

  def king_moves_into_check
    kings = kings_on_board
    kings.each do |king|
      0.upto(7) do |x|
        0.upto(7) do |y|
          return true if king.valid_move?(x, y) && check?
        end
      end
    end
  end

  def kings_on_board
    pieces.where(x_coordinate: 0..7, y_coordinate: 0..7, type: 'King', color: 'white')
    pieces.where(x_coordinate: 0..7, y_coordinate: 0..7, type: 'King', color: 'black')
  end

  def draw
    stalemate?
  end

  def forfeit_game(current_player_id, game)
    game = self
    if current_player_id == player_1_id
      game.update_attributes(winning_player_id: player_2_id)
    else
      game.update_attributes(winning_player_id: player_1_id)
    end
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
