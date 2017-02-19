require 'rails_helper'

RSpec.describe Game, type: :model do
  describe '#available' do
    describe 'If there is no game at all' do
      it 'Should return an empty array' do
        expect(Game.available).to eq []
      end
    end

    describe 'If there are games' do
      before do |test|
        # a game that has both players
        FactoryGirl.create(:game)

        if test.metadata[:open_game]
          # a game that has only one player (player1)
          @game2 = FactoryGirl.create(:game, player_2: nil)

          # a game that has only one player (player2)
          @game3 = FactoryGirl.create(:game, player_1: nil)
        end
      end

      describe 'And all games have both players' do
        it 'Should return an empty array' do
          expect(Game.available).to eq []
        end
      end

      describe 'And there are some open games', :open_game do
        it 'Should return all open games' do
          expect(Game.available.count).to eq 2
          expect(Game.available).to include @game2
          expect(Game.available).to include @game3
        end
      end
    end
  end
  
  describe 'populate game' do
    it 'should populate the game with pieces' do
      game = FactoryGirl.build(:game)
      game.populate_game!
      expect(game.pieces.count).to eq(32)
    end
  end
end
