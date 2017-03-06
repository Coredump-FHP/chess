class Queen < Piece
  def valid_move?(destination_x, destination_y)
    return false unless on_board?(destination_x, destination_y)

    x_diff = (x_coordinate - destination_x).abs
    y_diff = (y_coordinate - destination_y).abs

    return true if x_diff == y_diff

    return true if x_diff.zero?

    return true if y_diff.zero?

    false
  end
end
