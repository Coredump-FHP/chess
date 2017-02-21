require 'rails_helper'

RSpec.describe King, type: :model do
  describe '#valid_move?' do
    it 'should move one step' do
      king = King.create(x_coordinate: 3, y_coordinate: 3)

      expect(king.valid_move?(2, 2)).to eq true
      expect(king.valid_move?(2, 3)).to eq true
      expect(king.valid_move?(2, 4)).to eq true
      expect(king.valid_move?(3, 2)).to eq true
      expect(king.valid_move?(3, 4)).to eq true
      expect(king.valid_move?(4, 2)).to eq true
      expect(king.valid_move?(4, 3)).to eq true
      expect(king.valid_move?(4, 4)).to eq true
    end

    it 'should not move more than one step' do
      king = King.create(x_coordinate: 4, y_coordinate: 4)

      (0..8).each do |x|
        (0..8).each do |y|
          # every place where x or 4 is more than 1 away
          if x < 3 || x > 5
            expect(king.valid_move?(x, y)).to eq false
          elsif y < 3 || y > 5
            expect(king.valid_move?(x, y)).to eq false
          end
        end
      end
    end

    it 'should not stand still' do
      king = King.create(x_coordinate: 5, y_coordinate: 5)

      (1..8).each do |x|
        (1..8).each do |y|
          # every spot on the board, will test not moving
          king = King.create(x_coordinate: x, y_coordinate: y)
          expect(king.valid_move?(x, y)).to (eq false), " expected (#{x},#{y}) not be able to stand still"
        end
      end
    end
  end
end
