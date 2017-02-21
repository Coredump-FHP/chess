require 'rails_helper'

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
    it 'should start with 32 pieces' do
      game = Game.create
      game.populate_game!
      array = game.pieces.map { |p| p }
      expect(array.count).to eq(32)
    end

    it 'should populate the game with the correct starting locations' do
      game = Game.create
      game.populate_game!
      # actual result from on spec\model\game.rb!
      actual = game.pieces.map do |p|
        { col: p.x_coordinate, row: p.y_coordinate,
          color: p.color, type: p.type }
      end

      # this is what the board should look like.
      # changes found on spec\model\game.rb, will cause test to fail
      expected = [
        { col: 1, row: 1, color: 'white', type: 'Rook', found: false },
        { col: 2, row: 1, color: 'white', type: 'Knight', found: false },
        { col: 3, row: 1, color: 'white', type: 'Bishop', found: false },
        { col: 4, row: 1, color: 'white', type: 'Queen', found: false },
        { col: 5, row: 1, color: 'white', type: 'King', found: false },
        { col: 6, row: 1, color: 'white', type: 'Bishop', found: false },
        { col: 7, row: 1, color: 'white', type: 'Knight', found: false },
        { col: 8, row: 1, color: 'white', type: 'Rook', found: false },

        { col: 1, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 2, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 3, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 4, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 5, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 6, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 7, row: 2, color: 'white', type: 'Pawn', found: false },
        { col: 8, row: 2, color: 'white', type: 'Pawn', found: false },

        { col: 1, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 2, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 3, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 4, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 5, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 6, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 7, row: 7, color: 'black', type: 'Pawn', found: false },
        { col: 8, row: 7, color: 'black', type: 'Pawn', found: false },

        { col: 1, row: 8, color: 'black', type: 'Rook', found: false },
        { col: 2, row: 8, color: 'black', type: 'Knight', found: false },
        { col: 3, row: 8, color: 'black', type: 'Bishop', found: false },
        { col: 4, row: 8, color: 'black', type: 'Queen', found: false },
        { col: 5, row: 8, color: 'black', type: 'King', found: false },
        { col: 6, row: 8, color: 'black', type: 'Bishop', found: false },
        { col: 7, row: 8, color: 'black', type: 'Knight', found: false },
        { col: 8, row: 8, color: 'black', type: 'Rook', found: false }
      ]
      # goes through each expected piece and find the first matching one in actual,
      # then mark both found
      expected.each do |e|
        first_actual = actual.select do |a|
          (a[:color] == e[:color]) && (a[:type] == e[:type]) && (a[:row] == e[:row]) && (a[:col] == e[:col])
        end.first

        e[:found] = true if first_actual
      end
      # expects that every expected piece was found.
      missing = expected.select { |p| !(p[:found]) }
      missing.each do |p|
        puts "Missing piece #{p}"
      end
      expect(missing.count).to eq(0)

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
