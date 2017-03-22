class King < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return false if own_piece?(x, y)
    return true if horizontal?(x, y) && (x_coordinate - x).abs == 1
    return true if vertical?(x, y) && (y_coordinate - y).abs == 1
    return true if diagonal?(x, y) && (x_coordinate - x).abs == 1 && (y_coordinate - y).abs == 1
    false # if not horizontal or vertical or diagonal or obstructed
  end

  def valid_moves # king doesnt need to look at whole board, just nearby
    moves = []

    (-1..1).each do |x_step|
      (-1..1).each do |y_step|
        x = x_step + x_coordinate
        y = y_step + y_coordinate
        moves.push(Move.new(x, y)) if valid_move?(x, y)
      end
    end
    moves
  end
end
