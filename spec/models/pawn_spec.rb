require 'rails_helper'

RSpec.describe Pawn, type: :model do
  describe '#valid_move?' do
    it 'should move up to 2 spaces on the first move' do
      pawn = Pawn.create(x_coordinate: 1, y_coordinate: 1)

      expect(pawn.first_move?(1, 2)).to eq true
      expect(pawn.first_move?(1, 3)).to eq true
      expect(pawn.first_move?(1, 6)).to eq false
    end

    it 'cannot move backwards' do
      pawn = Pawn.create(x_coordinate: 1, y_coordinate: 1)
      expect(pawn.backwards_move?(0)).to eq false
    end

    it 'cannot move horizontally on the board' do
      pawn = Pawn.create(x_coordinate: 1, y_coordinate: 1)
      expect(pawn.horizontal_move?(0)).to eq true
      expect(pawn.horizontal_move?(4)).to eq true
    end

    it 'can capture a piece' do
      pawn = Pawn.create(x_coordinate: 1, y_coordinate: 1)

      expect(pawn.capture_move?(2, 2)).to eq true
      expect(pawn.capture_move?(3, 3)).to eq false
    end

    it 'has a proper_length move of 1 (y) square at a time' do
      pawn = Pawn.create(x_coordinate: 1, y_coordinate: 1)

      expect(pawn.proper_length?(2)).to eq true
      expect(pawn.proper_length?(4)).to eq false
    end
  end
end
