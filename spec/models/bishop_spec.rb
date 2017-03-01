require 'rails_helper'
require 'pry'

RSpec.describe Bishop, type: :model do
  def create_bishop(x, y)
    FactoryGirl.create(:bishop, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should move diagonally lt-bottom to rt-top any number of steps on the board' do
      bishop = create_bishop(0, 0)

      (1..7).each do |dist|
        expect(bishop.valid_move?(0 + dist, 0 + dist)).to eq true
      end
    end

    it 'should move diagonally rt-top to lt-bottom any number of steps on the board' do
      bishop = create_bishop(7, 7)
      (6..0).each do |dist|
        expect(bishop.valid_move?(dist, dist)).to eq true
      end
    end

    it 'should move diagonally rt-bottom to lt-top any number of steps on the board' do
      bishop = create_bishop(7, 0)
      (7..0).each do |dist|
        expect(bishop.valid_move?(7 - dist, 0 + dist)).to eq true
      end
    end

    it 'should move diagonally lt-top to rt-bottom any number of steps on the board' do
      # 7 x
      # 6  B2
      # 5
      # 4
      # 3
      # 2
      # 1             B1
      # 0               x
      #  0 1 2 3 4 5 6 7
      # can't sit on starting position.  7-7 = 0 => 7-distance
      # bishop = create_bishop(0, 7)

      # expect(bishop.valid_move?(1, 6)).to eq true
      # expect(bishop.valid_move?(2, 5)).to eq true
      # expect(bishop.valid_move?(3, 4)).to eq true
      # expect(bishop.valid_move?(4, 3)).to eq true
      # expect(bishop.valid_move?(5, 2)).to eq true
      # expect(bishop.valid_move?(6, 1)).to eq true
      # expect(bishop.valid_move?(7, 0)).to eq true

      # (1..7).each do |dist|
      # (source_dist) + (7-dist) = (6) + (7 - 6) = 7
      # (source_dist) + (7-dist) = (2) + (7 - 2) = 7
      #  expect(bishop.valid_move?(0 + dist, 7 - dist)).to eq true
      # end
    end

    it 'should not move outside diagonal pattern' do
      bishop = create_bishop(6, 1)
      # test vertically
      expect(bishop.valid_move?(6, 0)).to eq false
      expect(bishop.valid_move?(6, 2)).to eq false
      # test horizontally
      expect(bishop.valid_move?(5, 1)).to eq false
      expect(bishop.valid_move?(7, 1)).to eq false
    end
  end
end
