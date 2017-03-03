class Rook < Piece

    def valid_move?(x,y) 
        vertical?(x,y) && !obstructed?(x,y) || horizonal(x,y) && !obstructed?(x,y) || castle_movement?(x,y)
    end

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

    #def castle_movement?(x,y)
        #initial_position?
        #initial_position = [[0,0],[1,1]].any? {|xx,yy| xx = x_coordinate && yy == y_coordinate }
        #initial_position && "specific movement"
        #initial_position  = x==0 && y ==1  && color=='black' || x==7 && y ==7 && color == 'white' ||

        #king?.x == 1 && 
    #end


end



