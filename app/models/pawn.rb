class Pawn < Piece
  def legal_move?(x, y)
    return false if backwards_move? y
    return false if horizontal_move? x
    return true if capture_move?(x,y)
    return false if game.obstructed?(x,y)
    return true if first_move?(y)

    proper_length?(y)
  end

  def capture_move?(x, y)
    x_diff = (x_coordinate - x).abs
    y_diff = (y_coordinate - y).abs
    captured_piece = piece.obstructed?(x, y)

    return false if captured_piece.blank?
    return false if captured_piece.color == color
    return true if x_diff == 1 && y_diff == 1
  end

  def horizontal_move?(x)
    x_diff = (x_coordinate - x).abs
    x_diff != 0
  end

  def backwards_move?(y)
    color ? y_coordinate > y : y_coordinate < y
  end

  def first_move?(x, y)
    (y_coordinate == 1 && color) || (y_coordinate == 6 && !color)
    y_diff = (y_coordinate - y).abs
    if y_diff == 1 || y_diff == 2
      return true
    else
      return false
    end
  end

  def proper_length?(y)
    (y - y_coordinate).abs == 1
  end
end
