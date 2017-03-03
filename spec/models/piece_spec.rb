require 'rails_helper'
require 'pry'
RSpec.describe Piece, type: :model do
  let(:game) { FactoryGirl.create(:game) }

  def create_chess(x, y)
    player1 = game.player_1
    FactoryGirl.create(:piece, x_coordinate: x, y_coordinate: y, player: player1, game: game)
  end

  describe '#obstructed?' do
    context 'When the inputs are invalid' do
      context 'Should raise an argument error' do
        it 'If current_chess_piece and sq2 have the same x and y coordinates' do
          current_chess_piece = create_chess(0, 1)
          destination_coord = { destination_x: 0, destination_y: 1 }

          expect do
            current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])
          end.to raise_error ArgumentError
        end

        context 'If current_chess_piece and sq2 have different x and y coordinates' do
          it 'and the x differences and y differences are not the same' do
            current_chess_piece = create_chess(0, 5)
            destination_coord = { destination_x: 1, destination_y: 2 }

            expect do
              current_chess_piece.obstructed?(destination_coord[:destination_x], destination_coord[:destination_y])
            end.to raise_error ArgumentError
          end
        end
      end
    end

    context 'When the inputs are valid' do
      context 'If current_chess_piece and sq2 have the same x coordinates' do
        context 'but not the same y coordinates' do
          it 'If there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 3, destination_y: 5 }

            # create a chess in-between
            create_chess(3, 4)

            expect(current_chess_piece).to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end

          it 'returns false if no obstructions' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 3, destination_y: 5 }

            expect(current_chess_piece).not_to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end
        end
      end

      context 'If current_chess_piece and sq2 have the same y coordinates' do
        context 'but not the same x coordinates' do
          it 'If there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 5, destination_y: 3 }

            # create a chess in-between
            create_chess(4, 3)

            expect(current_chess_piece).to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end

          it 'returns false if no obstructions' do
            current_chess_piece = create_chess(3, 3)
            destination_coord = { destination_x: 5, destination_y: 3 }

            expect(current_chess_piece).not_to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end
        end
      end

      context 'If current_chess_piece and sq2 have different x and y coordinates' do
        context 'and the x differences and y differences are the same' do
          it 'if there is a piece in between them, the result should be true' do
            current_chess_piece = create_chess(0, 0)
            destination_coord = { destination_x: 3, destination_y: 3 }

            # create a chess in-between
            create_chess(1, 1)

            expect(current_chess_piece).to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end

          it 'it returns false if no obstructions' do
            current_chess_piece = create_chess(0, 0)
            destination_coord = { destination_x: 3, destination_y: 3 }

            expect(current_chess_piece).not_to be_obstructed(destination_coord[:destination_x], destination_coord[:destination_y])
          end
        end
      end
    end
  end

  describe '#move_to!' do
    context 'when there is a piece there, and it`s the opposing color' do
      it 'should remove the piece from the board' do
        destination_piece = FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 3, color: 'black')
        game = destination_piece.game
        our_piece = FactoryGirl.create(:piece, game: game)

        # move our piece
        our_piece.move_to!(3, 3)
        destination_piece.reload

        # make sure the destination_piece's coordinates are removed
        expect(destination_piece.x_coordinate).to be_nil
        expect(destination_piece.y_coordinate).to be_nil
        # make sure the destination_piece is captured
        expect(destination_piece.captured).to be true
      end
    end

    context 'when there is a piece there, and it’s the same color' do
      it 'should raise an ArgumentError' do
        destination_piece = FactoryGirl.create(:piece, x_coordinate: 3, y_coordinate: 3)
        game = destination_piece.game
        our_piece = FactoryGirl.create(:piece, game: game)

        expect { our_piece.move_to!(3, 3) }.to raise_error ArgumentError
      end
    end

    it'should update destination to new x/y opponent location' do
      destination_piece = FactoryGirl.create(:piece, x_coordinate: 1, y_coordinate: 1, color: 'black')
      game = destination_piece.game
      our_piece = FactoryGirl.create(:piece, x_coordinate: 5, y_coordinate: 1, game: game)

      # move our piece
      our_piece.move_to!(1, 1)
      our_piece.reload

      expect(our_piece.x_coordinate).to eq 1
      expect(our_piece.y_coordinate).to eq 1
    end
  end

  describe '#on_board?' do
    it 'should return true is the coords are from 0 to 7' do
      piece = create_chess(5, 5)
      (0..7).each do |x|
        (0..7).each do |y|
          # all these are on the board
          expect(piece.on_board?(x, y)).to (eq true), "expected (#{x},#{y}) to be on the chess board"
        end
      end
    end

    it 'should return false if the coords not from 0 to 7' do
      piece = create_chess(5, 5)
      # Test with invalid x
      [*-4...0, *8..12].each do |x|
        [*-4..12].each do |y|
          # puts "trying (#{x},#{y})"
          # these aren't on the board because the x is wrong
          expect(piece.on_board?(x, y)).to (eq false), "expected (#{x},#{y}) to be outside the chess board"
        end
      end

      # Test with invalid y
      # http://stackoverflow.com/questions/21404323/combining-two-different-ranges-to-one-in-ruby
      [*-4..12].each do |x|
        [*-4...0, *8..12].each do |y|
          # these aren't on the board because the y is wrong
          expect(piece.on_board?(x, y)).to (eq false), "expected (#{x},#{y}) to be outside the chess board"
        end
      end
    end
  end
end
