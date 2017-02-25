require 'rails_helper'
require 'pry'

RSpec.describe Game, type: :model do
  describe '#available' do
    context 'When there is no game at all' do
      it 'Should return an empty array' do
        expect(Game.available).to eq []
      end
    end

    context 'When there are games' do
      let!(:game) { FactoryGirl.create(:game) }

      context 'When all games have both players' do
        it 'Should return an empty array' do
          expect(Game.available).to eq []
        end
      end

      context 'When there are some open games' do
        it 'Should return all open games' do
          # a game that has only one player (player1)
          game2 = FactoryGirl.create(:game, player_2: nil)

          # a game that has only one player (player2)
          game3 = FactoryGirl.create(:game, player_1: nil)

          expect(Game.available.count).to eq 2
          expect(Game.available).to include game2
          expect(Game.available).to include game3
        end
      end
    end
  end

  describe '#populate game' do
    def expect_a_piece(attributes)
      piece = game.pieces.where(attributes).first
      unless piece
        puts 'Missing piece'
        pp attributes
      end
      expect(piece).to be_a_kind_of(Piece)
    end

    let(:game) { FactoryGirl.create(:game) }

    before(:each) { game.populate_game! }

    it 'should start with 32 pieces' do
      expect(game.pieces.size).to eq(32)
    end

    it 'should not populate the game again if it has already been populated' do
      game = FactoryGirl.create(:game)
      game.populate_game!

      game.populate_game!
      expect(game.pieces.count).to eq 32
    end

    it 'should populate the game with the correct starting locations' do
      expect_a_piece(x_coordinate: 0, y_coordinate: 0, color: 'white', type: 'Rook')
      expect_a_piece(x_coordinate: 1, y_coordinate: 0, color: 'white', type: 'Knight')
      expect_a_piece(x_coordinate: 2, y_coordinate: 0, color: 'white', type: 'Bishop')
      expect_a_piece(x_coordinate: 3, y_coordinate: 0, color: 'white', type: 'Queen')
      expect_a_piece(x_coordinate: 4, y_coordinate: 0, color: 'white', type: 'King')
      expect_a_piece(x_coordinate: 5, y_coordinate: 0, color: 'white', type: 'Bishop')
      expect_a_piece(x_coordinate: 6, y_coordinate: 0, color: 'white', type: 'Knight')
      expect_a_piece(x_coordinate: 7, y_coordinate: 0, color: 'white', type: 'Rook')

      expect_a_piece(x_coordinate: 0, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 1, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 2, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 3, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 4, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 5, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 6, y_coordinate: 1, color: 'white', type: 'Pawn')
      expect_a_piece(x_coordinate: 7, y_coordinate: 1, color: 'white', type: 'Pawn')

      expect_a_piece(x_coordinate: 0, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 1, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 2, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 3, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 4, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 5, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 6, y_coordinate: 6, color: 'black', type: 'Pawn')
      expect_a_piece(x_coordinate: 7, y_coordinate: 6, color: 'black', type: 'Pawn')

      expect_a_piece(x_coordinate: 0, y_coordinate: 7, color: 'black', type: 'Rook')
      expect_a_piece(x_coordinate: 1, y_coordinate: 7, color: 'black', type: 'Knight')
      expect_a_piece(x_coordinate: 2, y_coordinate: 7, color: 'black', type: 'Bishop')
      expect_a_piece(x_coordinate: 3, y_coordinate: 7, color: 'black', type: 'Queen')
      expect_a_piece(x_coordinate: 4, y_coordinate: 7, color: 'black', type: 'King')
      expect_a_piece(x_coordinate: 5, y_coordinate: 7, color: 'black', type: 'Bishop')
      expect_a_piece(x_coordinate: 6, y_coordinate: 7, color: 'black', type: 'Knight')
      expect_a_piece(x_coordinate: 7, y_coordinate: 7, color: 'black', type: 'Rook')
    end
  end

  describe '#render_piece' do
    let(:game) { FactoryGirl.create(:game) }

    context 'When there is a piece for the coordinate' do
      it 'Should return the icon' do
        FactoryGirl.create(:piece, x_coordinate: 0, y_coordinate: 1, player: game.player_1, game: game, icon: 'myimage.png')

        expect(game.render_piece(0, 1)).to eq 'myimage.png'
      end
    end

    context 'When there is not a piece for the coordinate' do
      it 'Should return empty string' do
        expect(game.render_piece(0, 1)).to eq nil
      end
    end
  end
end
