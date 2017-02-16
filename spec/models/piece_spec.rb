require 'rails_helper'

RSpec.describe Piece, type: :model do
  describe '#obstructed?' do
    before do
      @player1 = FactoryGirl.create(:player)
      @player2 = FactoryGirl.create(:player)
      @game = Game.create(name: 'my game', player_1: @player1, player_2: @player2)
    end

    def create_chess(x, y)
      Piece.create(x_coordinate: x, y_coordinate: y, player: @player1, game: @game)
    end

    describe 'When the inputs are invalid' do
      describe 'Should raise an argument error' do
        it 'If current_chess_piece and sq2 have the same x and y coordinates' do
          current_chess_piece = create_chess(0, 1)
          destination_coord = { destination_x: 0, destination_y: 1 }

          expect { current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y]) }.to raise_error ArgumentError
        end

        describe 'If current_chess_piece and sq2 have different x and y coordinates' do
          it 'and the x differences and y differences are not the same' do
            current_chess_piece = create_chess(0, 5)
            destination_coord = { destination_x: 1, destination_y: 2 }

            expect { current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y]) }.to raise_error ArgumentError
          end
        end
      end
    end

    describe 'When the inputs are valid' do
      describe 'If current_chess_piece and sq2 have the same x coordinates' do
        describe 'but not the same y coordinates' do
          it 'If there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 3, destination_y: 5 }

            # create a chess in-between
            create_chess(3, 4)

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq true
          end

          it 'If there is nothing in between them, the result should be false' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 3, destination_y: 5 }

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq false
          end
        end
      end

      describe 'If current_chess_piece and sq2 have the same y coordinates' do
        describe 'but not the same x coordinates' do
          it 'If there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 5, destination_y: 3 }

            # create a chess in-between
            create_chess(4, 3)

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq true
          end

          it 'If there is nothing in between them, the result should be false' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 5, destination_y: 3 }

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq false
          end
        end
      end

      describe 'If current_chess_piece and sq2 have different x and y coordinates' do
        describe 'and the x differences and y differences are the same' do
          it 'if there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(0, 0)
            destination_coord = { destination_x: 3, destination_y: 3 }

            # create a chess in-between
            create_chess(1, 1)

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq true
          end

          it 'if there is nothing in between them, the result should be false' do
            current_chess_piece = create_chess(0, 0)
            destination_coord = { destination_x: 3, destination_y: 3 }

            expect(current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])).to eq false
          end
        end
      end
    end
  end
end
