require 'rails_helper'

RSpec.describe Queen, type: :model do
  def create_queen(x, y)
    FactoryGirl.create(:queen, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should be able to move horizontally to the rt' do
      queen = create_queen(4, 4)
      expect(queen.valid_move?(5, 4)).to eq true
      expect(queen.valid_move?(6, 4)).to eq true
      expect(queen.valid_move?(7, 4)).to eq true
    end

    it 'should be able to move horizontally to the lt' do
      queen = create_queen(4, 4)
      expect(queen.valid_move?(3, 4)).to eq true
      expect(queen.valid_move?(2, 4)).to eq true
      expect(queen.valid_move?(1, 4)).to eq true
      expect(queen.valid_move?(0, 4)).to eq true
    end

    it 'should be able to move vertically to the top' do
      queen = create_queen(4, 4)
      expect(queen.valid_move?(4, 5)).to eq true
      expect(queen.valid_move?(4, 6)).to eq true
      expect(queen.valid_move?(4, 7)).to eq true
    end

    it 'should be able to move vertically to the bottom' do
      queen = create_queen(4, 4)
      expect(queen.valid_move?(4, 3)).to eq true
      expect(queen.valid_move?(4, 2)).to eq true
      expect(queen.valid_move?(4, 1)).to eq true
      expect(queen.valid_move?(4, 0)).to eq true
    end

    it 'should move diagonally lt-bottom to rt-top any number of steps on the board' do
      queen = create_queen(0, 0)
      (1..7).each do |dist|
        expect(queen.valid_move?(dist, dist)).to eq true
      end
    end

    it 'should move diagonally lt-top to rt-bottom any number of steps on the board' do
      queen = create_queen(0, 7)
      (1..7).each do |dist|
        expect(queen.valid_move?(dist, 7 - dist)).to eq true
      end
    end

    it 'should move diagonally rt-top to lt-bottom any number of steps on the board' do
      queen = create_queen(7, 7)
      (6..0).each do |dist|
        expect(queen.valid_move?(dist, dist)).to eq true
      end
    end

    it 'should move diagonally rt-bottom to lt-top any number of steps on the board' do
      queen = create_queen(7, 0)
      (7..0).each do |dist|
        expect(queen.valid_move?(7 - dist, dist)).to eq true
      end
    end

    it 'should not move other steps' do
      queen = create_queen(4, 4)
      # test other steps
      expect(queen.valid_move?(5, 6)).to eq false
      expect(queen.valid_move?(0, 1)).to eq false
    end
  end
end
