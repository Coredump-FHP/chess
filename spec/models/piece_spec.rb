require 'rails_helper'

RSpec.describe Piece, type: :model do
  
  describe "#obstructed?" do
    # sq1 = [1, 7], sq2 = [3, 8] for example
    # what good inputs would be?
    # sq1 and sq2 have the same x value(sq1[0] == sq2[0]), but not the same y value(sq1[1] != sq2[1])
    # sq1 and sq2 have the same y value(sq1[1] == sq2[1]), but not the same x value(sq1[0] != sq2[0])
    # sq1 and sq2 have the same x diff and y diff (sq1[0]-sq2[0] == sq1[1]-sq2[1])
    
    describe "When the inputs are invalid" do
      describe "Should raise an argument error" do    
        it "If sq1 and sq2 have the same x and y coordinates" do
          # setup the test data
          sq1 = [0,1]
          sq2 = [0,1]
          # assertion
          expect(sq1.obstructed?(sq2)).to raise_error ArgumentError
        end

        describe "If sq1 and sq2 have different x and y coordinates" do
          it "and the x differences and y differences are not the same" do
            # setup the test data
            sq1 = [0,5]
            sq2 = [1,2]
            # assertion
            expect(sq1.obstructed?(sq2)).to raise_error ArgumentError
          end  
        end    
      end
    end
    
    describe "When the inputs are valid" do
      describe "If sq1 and sq2 have the same x coordinates" do
        describe "but not the same y coordinates" do
          it "If there is a piece in between them, the result should be true" do
            sq1 = [3, 3]
            sq2 = [3, 5]
            player1 = FactoryGirl.create(:player)
            player2 = FactoryGirl.create(:player)
            game = Game.create(name: 'my game', player_1: player1, player_2: player2)
            chess_piece = Piece.create(x_coordinate: 3, y_coordinate:4, player: player1, game: game)
        
            expect(sq1.obstructed?(sq2)).to eq true
          end
          
          it "If there is nothing in between them, the result should be false" do
            sq1 = [3, 3]
            sq2 = [3, 5]
            
            expect(sq1.obstructed?(sq2)).to eq false
          end
        end
      end
      
      describe "If sq1 and sq2 have the same y coordinates" do
        describe "but not the same x coordinates" do
          it "If there is a piece in between them, the result should be true" do
            sq1 = [3, 3]
            sq2 = [5, 3]
            player1 = FactoryGirl.create(:player)
            player2 = FactoryGirl.create(:player)
            game = Game.create(name: 'my game', player_1: player1, player_2: player2)
            chess_piece = Piece.create(x_coordinate: 4, y_coordinate:3, player: player1, game: game)
            
            expect(sq1.obstructed?(sq2)).to eq true
          end
          
          it "If there is nothing in between them, the result should be false" do
            sq1 = [3, 3]
            sq2 = [5, 3]
            
            expect(sq1.obstructed?(sq2)).to eq false
          end
        end
      end
      
      describe "If sq1 and sq2 have different x and y coordinates" do
        describe "and the x differences and y differences are the same" do
          it "if there is a piece in between them, the result should be true" do
            sq1 = [0, 0]
            sq2 = [3, 3]
            player1 = FactoryGirl.create(:player)
            player2 = FactoryGirl.create(:player)
            game = Game.create(name: 'my game', player_1: player1, player_2: player2)
            chess_piece = Piece.create(x_coordinate: 1, y_coordinate:1, player: player1, game: game)
            
            expect(sq1.obstructed?(sq2)).to eq true
          end
          
          it "if there is nothing in between them, the result should be false" do
            sq1 = [0, 0]
            sq2 = [3, 3]
          
            expect(sq1.obstructed?(sq2)).to eq false
          end
        end
      end
      
    end
    
  end
end
