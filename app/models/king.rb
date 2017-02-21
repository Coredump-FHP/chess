class King < Piece
  def valid_move?(destination_x, destination_y)
    return false unless on_board?(destination_x, destination_y)

    return true if [x_coordinate - 1, y_coordinate + 1] == [destination_x, destination_y]
    return true if [x_coordinate + 0, y_coordinate + 1] == [destination_x, destination_y]
    return true if [x_coordinate + 1, y_coordinate + 1] == [destination_x, destination_y]
    return true if [x_coordinate - 1, y_coordinate + 0] == [destination_x, destination_y]
    return true if [x_coordinate + 1, y_coordinate + 0] == [destination_x, destination_y]
    return true if [x_coordinate - 1, y_coordinate - 1] == [destination_x, destination_y]
    return true if [x_coordinate + 0, y_coordinate - 1] == [destination_x, destination_y]
    return true if [x_coordinate + 1, y_coordinate - 1] == [destination_x, destination_y]
    # Unconditional fail returns false even for nil
    false
  end
end
