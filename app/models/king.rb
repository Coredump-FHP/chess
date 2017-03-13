class King < Piece
  def valid_move?(x, y)
    return false unless on_board?(x, y)
    return true if horizontal?(x, y) && (x_coordinate - x).abs == 1
    return true if vertical?(x, y) && (y_coordinate - y).abs == 1
    return true if diagonal?(x, y) && (x_coordinate - x).abs == 1 && (y_coordinate - y).abs == 1
    false # if not horizontal or vertical or diagonal or obstructed
  end

  # moves to every spot on the board and push the piece on to the board if it's a valid move
  def valid_moves

  	moves = []

  	(0..7).each do |x|
  	  (0..7).each do |y|
  	  	if valid_move?(x,y)
  	  		moves.push(x,y) 
  	  	end
  	  end 
  	end

  	return moves
  end 
end
