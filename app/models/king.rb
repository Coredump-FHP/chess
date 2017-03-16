class King < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if horizontal?(x, y) && (x_coordinate - x).abs == 1
    return true if vertical?(x, y) && (y_coordinate - y).abs == 1
    return true if diagonal?(x, y) && (x_coordinate - x).abs == 1 && (y_coordinate - y).abs == 1
    false # if not horizontal or vertical or diagonal or obstructed
  end

  # TODO: Add valid moves in each piece class
  # TODO: get someone to get move_to unmutated to work properly. Getting undefined method error
  # TODO: [x] update attribute within move_to also mutates.. how do we not mutate it?  assign_attributes is the same as
  #       update_attribute without the save
  # TODO: [x] bug? - misstep can eat pieces when testing moves, so we'll need to make dead pieces come back to life.

  # moves to every spot on the board and push the piece on to the board if it's a valid move
  def valid_moves # used by misstep for test moves.
    moves = []

    (0..7).each do |x|
      (0..7).each do |y|
        moves.push(x, y) if valid_move?(x, y)
      end
    end
    moves
  end
end
