require 'rails_helper'

RSpec.describe King, type: :model do
  def create_king(x, y)
    FactoryGirl.create(:king, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should move one step' do
      king = create_king(3, 3)
      # there is only 8 squares the King walk to
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
      king = create_king(4, 4)

      (0..7).each do |x|
        (0..7).each do |y|
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
      king = create_king(5, 5)

      (0..7).each do |x|
        (0..7).each do |y|
          # every spot on the board, will test not moving
          king = create_king(x, y)
          expect(king.valid_move?(x, y)).to (eq false), " expected (#{x},#{y}) for king not be able to stand still"
        end
      end
    end
  end
end
