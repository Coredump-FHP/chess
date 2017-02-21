class Piece < ApplicationRecord
  belongs_to :player, class_name: 'Player', optional: true
  belongs_to :game

  enum color: %w(white black)

  def obstructed?(destination_x, destination_y)
    x_difference = x_coordinate - destination_x
    y_difference = y_coordinate - destination_y

    chess_in_between = []

    # first, raise an argument error when self and sq have the same coordinates
    if x_difference.zero? && y_difference.zero?
      raise ArgumentError, 'destination has to have a different location'
    elsif x_difference.zero?
      # the two locations are on the same vertical line
      chess_in_between = game.pieces.where(x_coordinate: x_coordinate)
                             .where(y_coordinate: y_coordinate + 1...destination_y)
    elsif y_difference.zero?
      # the two locations are on the same horizontal line
      chess_in_between = game.pieces.where(y_coordinate: y_coordinate)
                             .where(x_coordinate: x_coordinate + 1...destination_x)

    elsif x_difference != y_difference
      raise ArgumentError, 'destination must be on the diagonal of the origin'
    else
      # the two locations are on the same diagonal line
      chess_in_between = game.pieces.where(x_coordinate: x_coordinate + 1...destination_x)
                             .where(y_coordinate: y_coordinate + 1...destination_y)
                             .where("(x_coordinate - #{x_coordinate}) = (y_coordinate- #{y_coordinate})")

    end

    !chess_in_between.empty?
  end
end
