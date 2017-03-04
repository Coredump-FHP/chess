class King < Piece
  def valid_move?(destination_x, destination_y)
    # find the absolute value of the distance between the starting coordinates and the destination coordinates
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    # king moves one step vertically, horizontally and diagonally
    return true if [x_distance, y_distance] == [0, 1]
    return true if [x_distance, y_distance] == [1, 0]
    return true if [x_distance, y_distance] == [1, 1]

    # Unconditional fail returns false even for nil
    false
  end
end
