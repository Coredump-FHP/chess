require 'rails_helper'
require 'pry'

RSpec.describe Bishop, type: :model do
  def create_bishop(x, y)
    FactoryGirl.create(:bishop, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should move diagonally lt-bottom to rt-top any number of steps on the board' do
      # bishop = create_bishop(0, 0)

      # (0..7).each do |_dist|
      #  (0..7).each do |dist|
      # binding.pry
      # test the distance between the source and the destination
      # expect(bishop.valid_move?(dist+0, dist+1)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+2)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+3)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+4)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+5)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+6)).to eq true
      # expect(bishop.valid_move?(dist+0, dist+7)).to eq true
      # end
      # end
    end

    it 'should move diagonally rt-top to lt-bottom any number of steps on the board' do
      #  bishop = create_bishop(7, 7)
      #  (7..0).each do |dist|
      #    expect(bishop.valid_move?(dist, dist)).to eq true
      #  end
    end

    it 'should move diagonally rt-bottom to lt-top any number of steps on the board' do
      # bishop = create_bishop(7, 0)
      # y
      # |
      # 7
      # 6
      # 5
      # 4
      # 3
      # 2
      # 1             B
      # 0               x
      #   0 1 2 3 4 5 6 7--x
      # binding.pry
      # (7..0).each do |dist|
      #  expect(bishop.valid_move?(7-dist, 0-dist)).to eq true
      # end
    end

    it 'should move diagonally lt-top to rt-bottom any number of steps on the board' do
      # bishop = create_bishop(0, 7)
      # (0..7).each do |dist|
      # y
      # |
      # 7 x
      # 6   B
      # 5
      # 4
      # 3
      # 2
      # 1
      # 0
      #   0 1 2 3 4 5 6 7--x
      # binding.pry
      # expect(bishop.valid_move?(dist, 7-dist)).to eq true
      # end
    end

    it 'should not move vertically or horizontally' do
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
