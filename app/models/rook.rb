class Rook < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if vertical?(x, y) && !obstructed_vertically?(y)
    return true if horizontal?(x, y) && !obstructed_horizontally?(x)
    false # if not horizontal or vertical or obstructed
  end

  private

  def vertical?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance.zero? && y_distance.nonzero?
  end

  def horizontal?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance.nonzero? && y_distance.zero?
  end
end
