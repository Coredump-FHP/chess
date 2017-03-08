class Knight < Piece
  def valid_move?(destination_x, destination_y)
    return false unless on_board?(destination_x, destination_x)

    # check that there is nothing in between source and dest
    return false if obstructed?(destination_x, destination_y)

    # find the absolute value of the difference between current_coordinates and the destination_coordinates
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    # knights move in L vertical steps
    return true if [x_distance, y_distance] == [1, 2]
    # knights move in L horizontal steps
    return true if [x_distance, y_distance] == [2, 1]

    false
  end
end
