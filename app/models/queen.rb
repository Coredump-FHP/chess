class Queen < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false if obstructed?(x, y)
    return true if vertical?(x, y) || horizontal?(x, y) || diagonal?(x, y)
    false # if not horizontal or vertical or obstructed
  end
end
