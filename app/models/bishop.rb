class Bishop < Piece
  def valid_move?(destination_x, destination_y)
    # check that there is nothing in between source and dest
    # return false if obstructed?(destination_x, destination_y)

    # find the absolute value of the distance between the starting coordinates and the destination coordinates
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    # bishops moves diagonally any number of steps.
    return true if x_distance == y_distance
    false
  end
end
