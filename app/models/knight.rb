class Knight < Piece
  def valid_move?(destination_x, destination_y)
    return false unless on_board?(destination_x, destination_y)

    # find the absolute value of the difference between current_coordinates and the destination_coordinates
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    # calculate vertical first
    # x_dist [x + 0 - x - 1] = -1  abs => 1
    # y_dist [y + 0 - y + 2] = +2  abs => 2

    # calculate horizontal first
    # x_dist [x + 0 - x - 2] = -2  abs => 2
    # y_dist [y + 0 - y - 1] = -1  abs => 1

    # knights move in L steps
    return true if [x_distance, y_distance] == [1, 2]
    return true if [x_distance, y_distance] == [2, 1]

    # Unconditional fail returns false even for nil
    false
  end
end
