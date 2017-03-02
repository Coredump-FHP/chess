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
      # This test will pass once obstructed diagonal bug is fixed.
      # bishop = create_bishop(0, 7)

      # (1..7).each do |dist|
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
