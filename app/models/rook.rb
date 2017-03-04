class Rook < Piece
  def vertical?(destination_x, destination_y)
    x_difference = x_coordinate - destination_x
    y_difference = y_coordinate - destination_y

    x_difference.zero? && y_difference.nonzero?
  end

  def horizontal?(destination_x, destination_y)
    x_difference = x_coordinate - destination_x
    y_difference = y_coordinate - destination_y

    x_difference.nonzero? && y_difference.zero?
  end

  def valid_move?(x, y)
    vertical?(x, y) && !obstructed?(x, y) || horizontal?(x, y) && !obstructed?(x, y)
  end
end
