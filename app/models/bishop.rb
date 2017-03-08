class Bishop < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if diagonal?(x, y) && !obstructed_diagonally?(x, y)
    false # if not horizontal or vertical or obstructed
  end

  private

  def diagonal?(x, y)
    (x_coordinate - x).abs == (y_coordinate - y).abs
  end
end
