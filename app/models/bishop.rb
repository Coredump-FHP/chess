class Bishop < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false if own_piece?(x, y)
    return true if diagonal?(x, y) && !obstructed_diagonally?(x, y)
    false # if not horizontal or vertical or obstructed
  end
end
