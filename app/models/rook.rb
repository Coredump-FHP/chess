class Rook < Piece
   def vertical?(destination_x, destination_y)
       x_difference = x_coordinate - destination_x
       y_difference = y_coordinate - destination_y
       x_difference.zero? && y_difference.nonzero?
      end

    def horizontal?(destination_x, destination_y)
        x_difference = x_coordinate - destination_x
        y_difference = y_coordinate - destination_y

        x_difference.nonzero? && y_difference.zero?
      end

    def valid_move?(x, y)
        x_diff = x_coordinate - x
        y_diff = y_coordinate - y

        if x_diff = 0 && !obstructed?(x,y)
          return true
        elsif  y_diff = 0 && !obstructed?(x,y)
          return true
        end
    end
end
