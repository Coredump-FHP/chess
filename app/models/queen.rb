class Queen < Piece
   def valid_move?(destination_x, destination_y)
   return false unless on_board?(destination_x, destination_x)
   return false if obstructed?(destination_x, destination_y)
   end
end
