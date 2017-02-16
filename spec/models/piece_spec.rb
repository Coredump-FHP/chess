require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  describe "#obstructed?" do
    # current_chess_piece being a Piece object having (x_coord: 1, y_coor: 2), sq2 = [3, 8] for example
    # what good inputs would be?
    # current_chess_piece and sq2 have the same x value(current_chess_piece.x_coordinate == sq2[0]), but not the same y value(current_chess_piece.y_coordinate != sq2[1])
    # current_chess_piece and sq2 have the same y value(current_chess_piece.y_coordinate] == sq2[1]), but not the same x value(current_chess_piece.x_coordinate != sq2[0])
    # current_chess_piece and sq2 have the same x diff and y diff (current_chess_piece.x_coordinate-sq2[0] == current_chess_piece.y_coordinate-sq2[1])
    
    before do 
      @player1 = FactoryGirl.create(:player)
      @player2 = FactoryGirl.create(:player)
      @game = Game.create(name: 'my game', player_1: @player1, player_2: @player2)
    end
    
    def create_chess(x, y)
      Piece.create(x_coordinate: x, y_coordinate: y, player: @player1, game: @game)
    end
    
    describe "When the inputs are invalid" do
      describe "Should raise an argument error" do    
        it "If current_chess_piece and sq2 have the same x and y coordinates" do
          current_chess_piece = create_chess(0, 1)
      
          sq2 = [0,1]
          # assertion
          expect{current_chess_piece.obstructed?(sq2)}.to raise_error ArgumentError
        end

        describe "If current_chess_piece and sq2 have different x and y coordinates" do
          it "and the x differences and y differences are not the same" do
            current_chess_piece = create_chess(0, 5)
            
            sq2 = [1,2]
            # assertion
            expect{current_chess_piece.obstructed?(sq2)}.to raise_error ArgumentError
          end  
        end    
      end
    end
    
    describe "When the inputs are valid" do
      describe "If current_chess_piece and sq2 have the same x coordinates" do
        describe "but not the same y coordinates" do
          it "If there is a piece in between them, the result should be true" do
            current_chess_piece = create_chess(3, 3)
          
            sq2 = [3, 5]
            
            chess_piece = create_chess(3, 4)
        
            expect(current_chess_piece.obstructed?(sq2)).to eq true
          end
          
          
          it "If there is nothing in between them, the result should be false" do
            current_chess_piece = create_chess(3, 3)
            sq2 = [3, 5]
            
            expect(current_chess_piece.obstructed?(sq2)).to eq false
          end
        end
      end
      
      describe "If current_chess_piece and sq2 have the same y coordinates" do
        describe "but not the same x coordinates" do
          it "If there is a piece in between them, the result should be true" do
            current_chess_piece = create_chess(3, 3)
          
            sq2 = [5, 3]
            chess_piece = create_chess(4, 3)
            
            expect(current_chess_piece.obstructed?(sq2)).to eq true
          end
          
          it "If there is nothing in between them, the result should be false" do
            sq2 = [5, 3]
            current_chess_piece = create_chess(3, 3)
            
            expect(current_chess_piece.obstructed?(sq2)).to eq false
          end
        end
      end
      
      describe "If current_chess_piece and sq2 have different x and y coordinates" do
        describe "and the x differences and y differences are the same" do
          it "if there is a piece in between them, the result should be true" do
            current_chess_piece = create_chess(0, 0)
            sq2 = [3, 3]
            chess_piece = create_chess(1, 1)
            
            expect(current_chess_piece.obstructed?(sq2)).to eq true
          end
          
          it "if there is nothing in between them, the result should be false" do
            current_chess_piece = create_chess(0, 0)
            sq2 = [3, 3]
          
            expect(current_chess_piece.obstructed?(sq2)).to eq false
          end
        end
      end
      
    end
    
  end
end
