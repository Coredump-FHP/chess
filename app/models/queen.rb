class Queen < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if vertical?(x, y) && !obstructed_vertically?(y)
    return true if horizontal?(x, y) && !obstructed_horizontally?(x)
    return true if diagonal?(x, y) && !obstructed_diagonally?(x, y)
    false # if not horizontal or vertical or obstructed
  end
end
