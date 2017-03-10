class Pawn < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false if horizontal_move? x
    return true if capture_move?(x, y)
    return false if obstructed_vertically?(x, y)
    return true if first_move?(y)
    return false if color == 'white' && south?(y)
    return false if color == 'black' && north(y)

    proper_length?(y)
  end

  def capture_move?(x, y)
    x_diff = (x_coordinate - x).abs
    y_diff = (y_coordinate - y).abs
    return true if x_diff == 1 && y_diff == 1
    return false if x_diff > 1 && y_diff > 1
  end

  def horizontal_move?(x)
    x_diff = (x_coordinate - x).abs
    x_diff != 0
  end

  def north?(y)
    ((y_coordinate - y) > 0)
  end

  def south?(y)
    ((y_coordinate - y) < 0)
  end

  def first_move?(_x, y)
    (y_coordinate == 1 && color) || (y_coordinate == 6 && !color)
    y_diff = (y_coordinate - y).abs
    return true if y_diff == 1 || y_diff == 2
    false
  end

  def proper_length?(y)
    (y - y_coordinate).abs == 1
  end
end
