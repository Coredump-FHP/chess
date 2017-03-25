class Queen < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false if own_piece?(x, y)
    return false if obstructed?(x, y)
    return true if vertical?(x, y) || horizontal?(x, y) || diagonal?(x, y)
    false # if not horizontal or vertical or obstructed
  end

  # Queen tries each direction and takes as many steps as it can. If it hits an invalid move,
  # stop going that direction, otherwise add the valid move to the list
  def valid_moves
    moves = []

    # go in all directions
    (-1..1).each do |_x_step|
      (-1..1).each do |_y_step|
        # start walking in that direction
        (1..7).each do |steps|
          x = x_coordinate + steps * x_direction
          y = y_coordinate + steps * y_direction

          # stop walking if you hit a wall
          break unless valid_move?(x, y)

          # remember the valid moves
          moves.push(Move.new(x, y))
        end
      end
    end
    moves
  end
end
