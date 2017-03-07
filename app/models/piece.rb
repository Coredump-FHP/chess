require 'pry'
class Piece < ApplicationRecord
  belongs_to :player, class_name: 'Player', optional: true
  belongs_to :game

  enum color: %w(white black)

  def on_board?(destination_x, destination_y)
    return false if destination_x < 0 || destination_x > 7 || destination_y < 0 || destination_y > 7
    true
  end

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
    raise ArgumentError, "Can't move piece" unless update_attributes(x_coordinate: new_x, y_coordinate: new_y)
  end

  # if a user tries to move a piece to an invalid position the move will fail.
  def valid_move?(_x, _y)
    # check destination piece is on the board
    return false unless on_board?(destination_x, destination_y)
    # check that there is nothing in between source and dest
    return false if obstructed?(destination_x, destination_y)

    return false unless move_to!(new_x, new_y)

    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs
    returns false unless x_distance.zero? && y_distance.zero?
    true
  end

  def obstructed?(destination_x, destination_y)

    return true if vertically_obstructed?(destination_y)
    return true if horizontally_obstructed?(destination_x)
    return true if diagonally_obstructed?(destination_x, destination_y)
    false
  end

  def square_is_occupied(destination_x, destination_y)
    # returns the square is occupied
    game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y, captured: false).exists?
  end

  # check diagonal obstruction
  def diagonally_obstructed?(destination_x, destination_y)
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    # if moving rt, x_dir is positive
    x_dir = destination_x > x_coordinate ? 1 : -1
    # if moving up, y_dir is positive
    y_dir = destination_y > y_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if (x_distance < 2) && (y_distance < 2)

    (1..(x_distance - 1)).each do |step|
      x_steps = step * x_dir
      y_steps = step * y_dir
      x_square = x_coordinate + x_steps
      y_square = y_coordinate + y_steps

      return true if square_is_occupied(x_square, y_square)
    end
    false
  end

  # checks for horizontal obstruction
  def horizontally_obstructed?(destination_x)
    x_distance = (x_coordinate - destination_x).abs

    # if moving right, x_dir is positive
    x_dir = destination_x > x_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if x_distance < 2

    (1..(x_distance - 1)).each do |step| # number of steps horizontally
      x_steps = step * x_dir
      y_steps = step * 0
      x_square = x_coordinate + x_steps
      y_square = y_coordinate + y_steps

      return true if square_is_occupied(x_square, y_square)
    end
    false
  end


  # checks for vertical obstruction
  def vertically_obstructed?(destination_y)
    y_distance = (y_coordinate - destination_y).abs

    # if moving for vertical obstruction
    y_dir = destination_y > x_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if y_distance < 2
    # distance -1 means we go one less than the distance because we don't count the end distance
    (1..(y_distance - 1)).each do |step| # number of steps vertically
      x_steps = step + 0
      y_steps = step * y_dir
      x_square = x_coordinate + x_steps
      y_square = y_coordinate + y_steps

      return true if square_is_occupied(x_square, y_square)
    end
    false
  end
end
