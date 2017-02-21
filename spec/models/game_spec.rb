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

  describe '#populate_game' do
    it 'should populate the game with pieces' do
      game = FactoryGirl.build(:game)
      game.populate_game!
      expect(game.pieces.count).to eq(32)
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
