require 'rails_helper'

RSpec.describe Knight, type: :model do
  def create_knight(x, y)
    FactoryGirl.create(:knight, x_coordinate: x, y_coordinate: y)
  end

  describe '#valid_move?' do
    it 'should only move in L steps' do
      knight = create_knight(3, 3)
      # up L
      expect(knight.valid_move?(2, 5)).to eq true
      expect(knight.valid_move?(4, 5)).to eq true
      # rt L
      expect(knight.valid_move?(5, 4)).to eq true
      expect(knight.valid_move?(5, 2)).to eq true
      # lt L
      expect(knight.valid_move?(2, 1)).to eq true
      expect(knight.valid_move?(4, 1)).to eq true
      # down L
      expect(knight.valid_move?(1, 4)).to eq true
      expect(knight.valid_move?(1, 2)).to eq true
    end

    it 'should not move outside L steps' do
      knight = create_knight(3, 3)
      # test 1 step left horizontal
      expect(knight.valid_move?(2, 3)).to eq false
      # test 1 step up vertical
      expect(knight.valid_move?(3, 4)).to eq false
      # test > 1 steps diagonally in negative direction
      expect(knight.valid_move?(0, 0)).to eq false
      # test incorrect steps
      expect(knight.valid_move?(7, 5)).to eq false

    end

    it 'should not stand still' do
      knight = create_knight(0, 0)

      (0..7).each do |x|
        (0..7).each do |y|
          # every spot on the board, will test not moving
          knight = create_knight(x, y)
          expect(knight.valid_move?(x, y)).to (eq false), " expected (#{x},#{y}) for knight not be able to stand still"
        end
      end
    end
  end
end
