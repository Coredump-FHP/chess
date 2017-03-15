require 'pry'
class Piece < ApplicationRecord
  belongs_to :player, class_name: 'Player', optional: true
  belongs_to :game

  enum color: %w(white black)

  # This uses ActiveRecords transactions determine potential moves of pieces being put in check
  # Remembers the moves and rolls back out
  def potential_move
    Piece.transaction do
      return false unless Piece.in_check?
    end
  end

  def opposite_color
    color == 'white' ? 'black' : 'white'
  end

  # x = destination_x for readability
  # y = destination_y for readability
  def on_board?(x, y)
    return false if x < 0
    return false if y < 0
    return false if x > 7
    return false if y > 7
    true
  end

  # Note: This method does not check if a move is valid. We will be using the valid_move? method to do that.
  def move_to!(x, y)
    # check to see if there is a piece in the location it`s moving to.
    destination_piece = Piece.find_by(game: game, x_coordinate: x, y_coordinate: y, captured: false)

    # Second, if there is a piece there, and it's the opposing color, remove the piece from the board.
    if destination_piece
      # Third, if the piece is there and it's the same color the move should fail - it should either raise an error message or do nothing.
      raise ArgumentError, "Can't take your own piece!" if destination_piece.color == color

      # You could set the piece's x/y coordinates to nil
      destination_piece.update_attributes(x_coordinate: nil, y_coordinate: nil, captured: true)
    end
    # Finally, it should call update_attributes on the piece and change the piece's x/y position.
    # http://apidock.com/rails/ActiveRecord/Base/update_attributes
    raise ArgumentError, "Can't move piece" unless update_attributes(x_coordinate: x, y_coordinate: y)
  end

  # testing potential moves - move will not be saved
  def move_to(x, y)
    # check to see if there is a piece in the location it`s moving to.
    test_destination_piece = Piece.find_by(game: game, x_coordinate: x, y_coordinate: y, captured: false)

    # Second, if there is a piece there, and it's the opposing color, remove the piece from the board.
    if test_destination_piece
      # Third, if the piece is there and it's the same color the move should fail - it should either raise an error message or do nothing.
      raise ArgumentError, "Can't take your own piece!" if test_destination_piece.color == color

      # You could set the piece's x/y coordinates to nil
      test_destination_piece.update_attributes(x_coordinate: nil, y_coordinate: nil, captured: true)
    end
    # Finally, it should call update_attributes on the piece and change the piece's x/y position.
    # http://apidock.com/rails/ActiveRecord/Base/update_attributes
    raise ArgumentError, "Can't move piece" unless update_attributes(x_coordinate: x, y_coordinate: y)
  end

  def obstructed?(x, y)
    # only check if obstructed in the direction you are moving
    return true if vertical?(x, y) && obstructed_vertically?(y)
    return true if horizontal?(x, y) && obstructed_horizontally?(x)
    return true if diagonal?(x, y) && obstructed_diagonally?(x, y)
    false
  end

  def square_is_occupied(x, y)
    # returns the square is occupied
    game.pieces.where(x_coordinate: x, y_coordinate: y, captured: false).exists?
  end

  # checks for horizontal obstruction
  def obstructed_horizontally?(x)
    x_distance = (x_coordinate - x).abs

    # if moving right, x_dir is positive
    x_dir = x > x_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if x_distance < 2
    # distance -1 means we go one less than the distance because we don't count the end distance
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
  def obstructed_vertically?(y)
    y_distance = (y_coordinate - y).abs

    # if moving for vertical obstruction
    y_dir = y > y_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if y_distance < 2
    # distance -1 means we go one less than the distance because we don't count the end distance
    (1..(y_distance - 1)).each do |step| # number of steps vertically
      x_steps = step * 0
      y_steps = step * y_dir
      x_square = x_coordinate + x_steps
      y_square = y_coordinate + y_steps

      return true if square_is_occupied(x_square, y_square)
    end
    false
  end

  # check diagonal obstruction
  def obstructed_diagonally?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    # if moving rt, x_dir is positive
    x_dir = x > x_coordinate ? 1 : -1
    # if moving up, y_dir is positive
    y_dir = y > y_coordinate ? 1 : -1

    # this checks if there are any steps in between the coordinate and destination
    return false if (x_distance < 2) && (y_distance < 2)
    # distance -1 means we go one less than the distance because we don't count the end distance
    (1..(x_distance - 1)).each do |step|
      x_steps = step * x_dir
      y_steps = step * y_dir
      x_square = x_coordinate + x_steps
      y_square = y_coordinate + y_steps

      return true if square_is_occupied(x_square, y_square)
    end
    false
  end

  # used by the different pieces in the subclasses
  def vertical?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance.zero? && y_distance.nonzero?
  end

  def horizontal?(x, y)
    x_distance = (x_coordinate - x).abs
    y_distance = (y_coordinate - y).abs

    x_distance.nonzero? && y_distance.zero?
  end

  def diagonal?(x, y)
    (x_coordinate - x).abs == (y_coordinate - y).abs
  end
end
