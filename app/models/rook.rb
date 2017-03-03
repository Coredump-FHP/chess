class Rook < Piece

    def vertical?(destination_x, destination_y)
      x_difference = x_coordinate - destination_x
      y_difference = y_coordinate - destination_y

      x_difference == 0 && y_difference  != 0
    end

    def horizontal?(destination_x, destination_y)
      x_difference = x_coordinate - destination_x
      y_difference = y_coordinate - destination_y

      x_difference != 0 && y_difference  == 0
    end

    def valid_move?(x,y) 
      vertical?(x,y) && !obstructed?(x,y) || horizontal?(x,y) && !obstructed?(x,y)
    end

end



