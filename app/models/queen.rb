class Queen < Piece
  def valid_move?(destination_x, destination_y)
    return false unless on_board?(destination_x, destination_y)
    return false if obstructed?(destination_x, destination_y)

    x_diff = (x_coordinate - destination_x).abs
    y_diff = (y_coordinate - destination_y).abs

    if x_diff == y_diff
      return true
    elsif x_diff.zero?
      return true
    elsif y_diff.zero?
      return true
    else
      return false
    end
  end
end
