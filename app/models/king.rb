class King < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if horizontal?(x, y) && (x_coordinate - x).abs == 1
    return true if vertical?(x, y) && (y_coordinate - y).abs == 1
    return true if diagonal?(x, y) && (x_coordinate - x).abs == 1 && (y_coordinate - y).abs == 1
    false # if not horizontal or vertical or diagonal or obstructed
  end
end
