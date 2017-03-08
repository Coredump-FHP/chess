class King < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if vertical?(x, y)
    return true if horizontal?(x, y)
    return true if diagonal?(x, y)
    false # if not horizontal or vertical or diagonal or obstructed
  end

  private

  def vertical?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance.zero? && y_distance == 1
  end

  def horizontal?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance == 1 && y_distance.zero?
  end

  def diagonal?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance == 1 && y_distance == 1
  end
end
