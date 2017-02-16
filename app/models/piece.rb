class Piece < ApplicationRecord
  belongs_to :player
  belongs_to :game

  def obstructed?(sq)
    # example of sq: [1, 2]
    # x_coord of sq: sq[0], y_coor of sq: sq[1]
    x_difference = x_coordinate - sq[0]
    y_difference = y_coordinate - sq[1]

    @chess_in_between = []
    # first, raise an argument error when self and sq have the same coordinates
    if x_difference.zero? && y_difference.zero?
      raise ArgumentError, 'location to check has to be different'
    elsif x_difference.zero?
      # the two locations are on the same vertical line
      # is there a chess piece on the same vertical line AND sits in between these two locations?
      # the x_coordinates of this chess piece == self.x_coordinate
      # the y_coordinates of the this chess piece should be in between (self.y_coordinate to sq[1])

      @chess_in_between = Piece.where(x_coordinate: x_coordinate)
                               .where(y_coordinate: y_coordinate + 1...sq[1])
    elsif y_difference.zero? # the two locations are on the same horizontal line
      @chess_in_between = Piece.where(y_coordinate: y_coordinate)
                               .where(x_coordinate: x_coordinate + 1...sq[0])
    elsif x_difference != y_difference
      raise ArgumentError, 'x and y difference are not the same'
    else # the two locations are on the same diagonal line
      # three conditions to check:
      # is the x_coord of the chess piece in between self.x_coordinate and sq[0]
      # is the y_coord of the chess piece in between self.y_coordinate and sq[1]
      # if the two conditions above are all satisfied, we also want to check
      @chess_in_between = Piece.where(x_coordinate: x_coordinate + 1...sq[0]) # making sure the x_coord of the chess piece in between self.x_coordinate and sq[0]
                               .where(y_coordinate: y_coordinate + 1...sq[1]) # making sure the y_coord of the chess piece in between self.y_coordinate and sq[1]
                               .where("(x_coordinate - #{x_coordinate}) = (y_coordinate- #{y_coordinate})")

    end

    !@chess_in_between.empty?
  end
end
