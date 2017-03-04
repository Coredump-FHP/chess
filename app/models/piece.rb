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
    return true if invalid?(destination_x, destination_y)

    return true if vertically_obstructed?(destination_y)
    return true if horizontally_obstructed?(destination_x)
    return true if diagonally_obstructed?(destination_x, destination_y)
    false
  end

  def square_is_occupied(destination_x, destination_y)
    # returns the square is occupied
    game.pieces.where(x_coordinate: destination_x, y_coordinate: destination_y, captured: false).exists?
  end

  def invalid?(destination_x, destination_y)
    # check destination piece is on the board
    raise ArgumentError, 'Error: Illegal Move' unless on_board?(destination_x, destination_y)

    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs
    return true if x_distance.zero? && y_distance.zero?
  end

  # check diagonal obstruction
  def diagonally_obstructed?(destination_x, destination_y)
    x_distance = (x_coordinate - destination_x).abs
    y_distance = (y_coordinate - destination_y).abs

    return false if (x_distance < 2) && (y_distance < 2)
    
    if destination_x > x_coordinate && destination_y > y_coordinate # slide rt top
      (1..(x_distance - 1)).each do |step|
        return true if square_is_occupied(x_coordinate + step, y_coordinate + step)
      end
    elsif destination_x < x_coordinate && destination_y < y_coordinate # slide lt bottom
      (1..(x_distance - 1)).each do |step|
        return true if square_is_occupied(x_coordinate - step, y_coordinate - step)
      end
    elsif destination_x < x_coordinate && destination_y > y_coordinate # slide lt top
      (1..(x_distance - 1)).each do |step|
        return true if square_is_occupied(x_coordinate - step, y_coordinate + step)
      end
    elsif destination_x > x_coordinate && destination_y < y_coordinate # slide rt bottom
      (1..(x_distance - 1)).each do |step|
        return true if square_is_occupied(x_coordinate + step, y_coordinate - step)
      end
    end
    false
  end

  # checks for horizontal obstruction
  def horizontally_obstructed?(destination_x)
    x_distance = (x_coordinate - destination_x).abs

    return false if x_distance < 2

    if destination_x > x_coordinate
      (1..(x_distance - 1)).each do |step| # slide right
        return true if square_is_occupied(x_coordinate + step, y_coordinate)
      end
    else
      (1..(x_distance - 1)).each do |step| # slide left
        return true if square_is_occupied(x_coordinate - step, y_coordinate)
      end
    end
    false
  end

  # checks for vertical obstruction
  def vertically_obstructed?(destination_y)
    y_distance = (y_coordinate - destination_y).abs

    return false if y_distance < 2

    if destination_y > y_coordinate
      # distance -1 means we go one less than the distance because we don't count the end distance
      (1..(y_distance - 1)).each do |step| # slide up
        return true if square_is_occupied(x_coordinate, y_coordinate + step)
      end
    else
      (1..(y_distance - 1)).each do |step| # slide down
        return true if square_is_occupied(x_coordinate, y_coordinate - step)
      end
    end
    false
  end
end
