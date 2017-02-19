require 'rails_helper'

RSpec.describe Game, type: :model do
  describe 'populate game' do
    it 'should populate the game with pieces' do
      game = FactoryGirl.build(:game)
      game.populate_game!
      expect(game.pieces.count).to eq(32)
    end
  end
end
