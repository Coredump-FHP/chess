require 'pry'
class Piece < ApplicationRecord
  belongs_to :player, class_name: 'Player', optional: true
  belongs_to :game

  enum color: %w(white black)

  # Note: This method does not check if a move is valid. We will be using the valid_move? method to do that.
  def move_to!(new_x, new_y)
    # check to see if there is a piece in the location it`s moving to.
    destination_piece = Piece.find_by(game: game, x_coordinate: new_x, y_coordinate: new_y, captured: false)

    # Second, if there is a piece there, and it's the opposing color, remove the piece from the board.
    if destination_piece
      # Third, if the piece is there and it's the same color the move should fail - it should either raise an error message or do nothing.
      raise ArgumentError, "Can't take your own piece!" if destination_piece.color == color

      # You could set the piece's x/y coordinates to nil
      destination_piece.update_attributes(x_coordinate: nil, y_coordinate: nil, captured: true)
    end
    # Finally, it should call update_attributes on the piece and change the piece's x/y position.
    # http://apidock.com/rails/ActiveRecord/Base/update_attributes
    raise ArgumentError, "Can't move piece" unless update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  def on_board?(destination_x, destination_y)
    return false if destination_x < 0
    return false if destination_x > 7
    return false if destination_y < 0
    return false if destination_y > 7
    true
  end

  def obstructed?(destination_x, destination_y)
    x_difference = x_coordinate - destination_x
    y_difference = y_coordinate - destination_y

    chess_in_between = []

    # first, raise an argument error when self and sq have the same coordinates
    raise ArgumentError, 'destination has to have a different location' if x_difference.zero? && y_difference.zero?

    if x_difference.zero?
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
